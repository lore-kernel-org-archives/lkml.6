Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0B8C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12C5322424
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Glj3CzYY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12C5322424
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932169AbeGCGv0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 02:51:26 -0400
Received: from mail-qt0-f176.google.com ([209.85.216.176]:47041 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753814AbeGCGvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 02:51:25 -0400
Received: by mail-qt0-f176.google.com with SMTP id h5-v6so676981qtm.13;
        Mon, 02 Jul 2018 23:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=snlcnn5kv+cNoCG0Glt7GTyEemUHcbjrnd2ldZBQZQM=;
        b=Glj3CzYYXvKR4GrXCc9XV20UPEpGsCt1Ht6bSxsEujF13+1XZiOScsrdIBrLlu+p0K
         +xdPRr7xXE8NqVQjKmtDItiSNf57DhOzQu59U6mxga4o0cm43hZoAPj7ziKwBfzFeV6k
         Azo/2M/2XKgb50cdhDh6YVbTyu6fnfw9C3pXBm95pGKQiDue9SpLocMkXw53r2XLVJeI
         5ovWFqTUgs9IkX6lnExv8eTpsSH8pa/oapL1mAMWJ0x7LuB+P7XWKG/y5sktavH0EdhE
         n8Zl3AR+c2naedSni6JYcPiIel6xzLCHt1GUKvH85r0zP0uOD669UqUq0e4NUhFZ8i71
         K6SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=snlcnn5kv+cNoCG0Glt7GTyEemUHcbjrnd2ldZBQZQM=;
        b=Puo2ILcTBRxPVUy4prlMxMgHAJpvyCIzp7uWjtReaxpIrwiUtHjyRsWNTdj0qD8COu
         FHEgAqflRsd264avJqLH76dhBXu0YfX3Gw1MpeLH+eiydv/M0fmolb12154/888E9qRF
         XJvW+8wsVqFrOHiGDkGoIiLf1gKxmH590qeN2Mf1FGDzpEOJmMam0vS1Up60lRIbUfr8
         EcDlBETZGPiIkLxGBESRTVez792T6yBVwM/YgSPawa2Wg2wfPQ6RY55tC8cYIjOZ8VSk
         CssVEHABuxVUMn1pHRPfufoOSlE0Mtpzt5spjXp6UVP7b1PI9rKd2lzh64HuiyBQP84h
         cVPw==
X-Gm-Message-State: APt69E2iiZKJsZluDiAbzpdgU9zf5u4JY8P03ENAkwqUgq+yuF2aVtRT
        Z+MceZUpwEhwAyE5ZmFkwNK1AZeTfGQUuJipTu06gB5y
X-Google-Smtp-Source: AAOMgpf0uIhfhMzrh5v81UD/FFp3T4nxqOUTAXG121dJvFfqs/VCLFfpy4lQZSAZ2EuFpsmNXSs/uk0vDNz61A2MR4g=
X-Received: by 2002:a0c:ad29:: with SMTP id u38-v6mr17535267qvc.12.1530600683130;
 Mon, 02 Jul 2018 23:51:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180628054205.17737-1-luaraneda@gmail.com> <20180628054205.17737-2-luaraneda@gmail.com>
 <d43b1758-cc0c-3a19-0d7d-f4773fe5caac@xilinx.com>
In-Reply-To: <d43b1758-cc0c-3a19-0d7d-f4773fe5caac@xilinx.com>
From:   Luis Araneda <luaraneda@gmail.com>
Date:   Tue, 3 Jul 2018 02:51:08 -0400
Message-ID: <CAHbBuxqXwaPL-mznVSkQ_nLdetj+StgiP6LjS1Qhq65aG_92EA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] arm: dts: zynq: Set correct manufacturer for
 ZedBoard and MicroZed boards
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On Thu, Jun 28, 2018 at 2:37 AM Michal Simek <michal.simek@xilinx.com> wrote:
>
> On 28.6.2018 07:42, Luis Araneda wrote:
> Unfortunately we don't know who is parsing this string. It means please
> keep that origin compatible string there.
>
> I have no problem with this.
> compatible = "avnet,zynq-zed", "xlnx,zynq-zed", "xlnx,zynq-7000";

Ok, I'll change that for V2, and I'll keep it in mind for the rest of
the series too.


Thanks for reviewing,

Luis Araneda.
