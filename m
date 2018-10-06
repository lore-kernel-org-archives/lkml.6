Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A17C00449
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 00:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FCB021473
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 00:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKH/egEf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FCB021473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729392AbeJFHaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 03:30:09 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40865 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbeJFHaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 03:30:09 -0400
Received: by mail-pl1-f196.google.com with SMTP id 1-v6so7530426plv.7;
        Fri, 05 Oct 2018 17:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wUUBVz9fyCO7JFOwc5JrJurfmtXq6AZpUbI7borXVnU=;
        b=kKH/egEfAdLg2MtKc78jqR9gEnhPUhQ+skYyR+w8Rh+FK94eQYMTloxOTmEqDmcJaT
         ISDrhEBKEiYlLnSJuaE3yCLV/+imepHubK3tCA4lHU5xVIa0YGCJCXvi2LLvfQQsvG1z
         k7k1GMOnnX8dtiXkXq3oC74XCx2FA/Dg1VdqKv/+gQxlU434Ine048ZBspPinCIQU2x0
         sv92eZZIXdAGS+dMDvHOeopWMoxcI7XiwG7s4HC/uBuSE+y6yFS/hEBjftlyD5E6XQmz
         DlzVjkT6/mwHsanqT8WEfde0tmUtY+w7DQ6Wf/b1mcqYWquZhbSukOCoVp3FlGKy/eke
         lrXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wUUBVz9fyCO7JFOwc5JrJurfmtXq6AZpUbI7borXVnU=;
        b=qgHCiVR5YkSqOmDhvFLwTUCZRYaFR9pgdlksbCVkRlj4Q0EKgIgsj2deEJZDUAI1AV
         xwKbqf2CkZQ3X+OcHmQO+87WIb9nIjxSL0ejVt0tpzsloC5KjTegngeo2oOVy89ZiIIs
         8JCo2eMIh9wagN0xZ755cZfONawzs4m0hoedbGMEMvx1xg+x1BFjUvPiW/699jK+NIoN
         3fJHx5CMSbmcHVH5qDfezcc9LDLPhWj6fArBJEfAOvjWPq6wpy5hxqj2oWijlwg1Qv2E
         5aW4AkXxlx1kfqjiDQ6jr8ryAyuxnC/HsF75/7fVPS9U8b1CChLXy2ao/0tYPffR4nKu
         cjdw==
X-Gm-Message-State: ABuFfoiXny7valvm/IYm4CPnCZ1wQ2MvI/l0JopV8aRldKPvSupXHiGk
        8kzqcBQyl1k5Lx89HaPFi/KI3eBBe9xvSvEOe2I=
X-Google-Smtp-Source: ACcGV62PqMzdI3wfZ3vWIR98Uy/A6VwVE5e7g/V3JHcOKpUc/iPAnKqeiDpnwqJfgxgEnNFremzsHmv7O7kR5L7tKwA=
X-Received: by 2002:a17:902:7b84:: with SMTP id w4-v6mr13413787pll.32.1538785740881;
 Fri, 05 Oct 2018 17:29:00 -0700 (PDT)
MIME-Version: 1.0
References: <20181003195121.6059-1-garrmcnu@gmail.com> <87va6i5dpo.fsf@suse.com>
In-Reply-To: <87va6i5dpo.fsf@suse.com>
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 5 Oct 2018 19:28:49 -0500
Message-ID: <CAH2r5msx5u4ouE-GuCE4P1LJ3ResLh-mD-3YTCnhBa8pwTCmoA@mail.gmail.com>
Subject: Re: [PATCH] fs/cifs: fix uninitialised variable warnings
To:     =?UTF-8?Q?Aur=C3=A9lien_Aptel?= <aaptel@suse.com>
Cc:     garrmcnu@gmail.com, CIFS <linux-cifs@vger.kernel.org>,
        Steve French <sfrench@samba.org>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

merged into cifs-2.6.git for-next
On Thu, Oct 4, 2018 at 3:16 AM Aur=C3=A9lien Aptel <aaptel@suse.com> wrote:
>
> Reviewed-by: Aurelien Aptel <aaptel@suse.com>
> --
> Aur=C3=A9lien Aptel / SUSE Labs Samba Team
> GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
> SUSE Linux GmbH, Maxfeldstra=C3=9Fe 5, 90409 N=C3=BCrnberg, Germany
> GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Norton, HRB 21284 (AG N=
=C3=BCrnberg)



--=20
Thanks,

Steve
