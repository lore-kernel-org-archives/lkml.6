Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62873C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D5D520844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ni7l7NLS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D5D520844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407270AbeHATOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:14:14 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:40523 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406599AbeHATOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:14:11 -0400
Received: by mail-pl0-f65.google.com with SMTP id s17-v6so9121230plp.7;
        Wed, 01 Aug 2018 10:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4DNR39Z33siHClcvkIzHJFx2bq4s5hwg5mUg3p1bGnw=;
        b=Ni7l7NLSWQKgNlpeTon4JPODWTb05yMv2zK0WNdGu4iYmZh7jCv8Ja11I5g/eTTcLz
         AabOpwkHw7HeXRr6Vk808RdGuvul4FcNdV5kLl+31wUdFmkw9qm5+i+Etvk/E7SbOphK
         aG1wG9Z+npXhFVSD0b1k+4Dm7Q5z8o9hoDHddo5UxCWsJEMaHoa17zMyeSOKdyYA7XSE
         C4560gPkM6XpRhZaCkQ7kt90ESgRbcpSFCvaOTb3+faYlsl2TDD7mxusop+zMFGZwJU/
         YAUKncq/pBwwpqCc98GC+cx3DtbtHcIJcOKKeun5HNXPjwRPD5SpOxbeP8nHgAQbbPqj
         SnNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4DNR39Z33siHClcvkIzHJFx2bq4s5hwg5mUg3p1bGnw=;
        b=N7UeYBSxxqI24n04Q4xbZFGTdGldgAw61C3PIJzFZkNk9EpJU1LjATwXOudvELHvpJ
         EG6JhGRPSxIqPlTMDiJAajtx6eI0VzxdKVxPKRoHpoVyQ/qRd8QYX3xAo+Qk/fwGV956
         /xJq/50pU1rQV4lY14KZTW2EY+QfuK/6ljlBZ2okurtbxV5/k/stxBSiRnSDjaW3wRw3
         /VBgzClujZD6l8pHQZSXLfwTdJ634+kMOprkwg/E8ikzlf9r1u0bNqLJ2DEoeLp0p97G
         XEOWIDz5GVzaoSfySqQZRlMJ2dZS3Dq8rz/C1R3Reqvrpy11XJUiqWYY9foIUblU7dUQ
         21AA==
X-Gm-Message-State: AOUpUlGacf/z9xA10/Thd2z+KmHGfEZGU0mJ7CKGMn0VtqnAvNwoA5eJ
        XCYVerTzOgIJzILb1Kv9oxGHtGUTzp5EPdenJws=
X-Google-Smtp-Source: AAOMgpfnQyXT6XgZiWTMqhXYucqW1B2w0a7sqJMFOZwvJD91XOmgs5a8T8DVLcMIy9htaeqs+JfHYo6wGOcb6qYShr8=
X-Received: by 2002:a17:902:42c3:: with SMTP id h61-v6mr25310835pld.319.1533142729238;
 Wed, 01 Aug 2018 09:58:49 -0700 (PDT)
MIME-Version: 1.0
References: <20180801205853.625673fd@canb.auug.org.au>
In-Reply-To: <20180801205853.625673fd@canb.auug.org.au>
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 1 Aug 2018 11:58:37 -0500
Message-ID: <CAH2r5mvJaQ41MPJTPtRBi_igW+74EHd7bo2Az0PMYSSQLUDepw@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the cifs tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed
On Wed, Aug 1, 2018 at 5:59 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Commits
>
>   e0afb3ebfcf5 ("cifs: add compound_send_recv()")
>   1bc941970813 ("cifs: make smb_send_rqst take an array of requests")
>   095fe7367830 ("cifs: update init_sg, crypt_message to take an array of rqst")
>
> are missing a Signed-off-by from their committers.
>
> --
> Cheers,
> Stephen Rothwell



-- 
Thanks,

Steve
