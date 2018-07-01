Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A81C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 22:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DC3A2583C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 22:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGPmqUsG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DC3A2583C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752559AbeGAWES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 18:04:18 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34747 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752407AbeGAWEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 18:04:15 -0400
Received: by mail-ed1-f66.google.com with SMTP id d3-v6so251467edi.1;
        Sun, 01 Jul 2018 15:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:openpgp:autocrypt:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=UDGViSBvKFUNRlIlOw8lpNEcWlpqy/qfV0Lh51l3Dfw=;
        b=CGPmqUsGTd7+5g6QGIrgS+GM/PHV68WVXHjIM257/YQen7surhanGo7D58X6ujkhH8
         N+z5bRuqQRp35F49l787/pGUxS4nZl98ST3KHiWFikytwFxXU/jkQr+5nL3Xf5POL75+
         jIDyhmKsYWWNK5MRorVBeVd44IA8ACRV9nTEY7p+mdBuLMSkv59JgKgMOPSvrR7enxkQ
         A5+QOVtxFgLG3XETu0Brv8toH93YxjvqMSPmIGuHsKGAWVWeyUv77k+002nU1KC90WBY
         mr8Z7BHE3wqAKd+4Veosoy3eJGMG8gUF0CdJV0sqORqjuIiqRIvA5e4aisTvh5t4p8Nd
         tCoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:content-transfer-encoding
         :content-language;
        bh=UDGViSBvKFUNRlIlOw8lpNEcWlpqy/qfV0Lh51l3Dfw=;
        b=rzwxU1MRhqwTXmKcniqbDj+Q02FPcAIpPK3iD/oLA7wRQ6J5jt5Pbf68FlNjyRswNX
         nEPRA1BOFJWQB/5MbJTkm/Nf407UyzVMHvZPLIpdImg8cxLXyDswhku6ETwQDmweqfGI
         /qwfG89JGoBKVDV/9lyVaYpG24e8rjVG2FPnSRvg9RVvFfOfc621K1ra2L0T3lNqZhLB
         GzHdno98olGpsdwDUkPAL89MXxwroLSvyKDEkg3Y+0Y0kw9IiD52dDRMDwVQGfrgZW8T
         pQOcgPpsHfx46xnyszqnDRCXdkt+h9p7J35fjCrcmu03rhyeXyrQ6VZP+76sMcMQC1gP
         +xuA==
X-Gm-Message-State: APt69E1eUPjqu0Vi8n18bwnHT5NvyCLknGKr2EYrekjKSZql1IepxVtm
        jHfsEErDdQY+EZNtaaGG5sOdsiOE
X-Google-Smtp-Source: AAOMgpdZ/xclZ2X9eMxB555SRWByvC0mXMnkt/IAEeoQxV5kpXVwJOahcZi1EDqoOZW52RaC5yPJZQ==
X-Received: by 2002:a50:93c5:: with SMTP id o63-v6mr21109959eda.311.1530482653885;
        Sun, 01 Jul 2018 15:04:13 -0700 (PDT)
Received: from [192.168.42.231] (pd-18-110-102.service.infuturo.it. [151.18.110.102])
        by smtp.gmail.com with ESMTPSA id g25-v6sm3022491edp.97.2018.07.01.15.04.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Jul 2018 15:04:12 -0700 (PDT)
To:     raven@themaw.net, autofs@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
From:   tomas <tomasbortoli@gmail.com>
Subject: [PATCH upstream] KASAN: slab-out-of-bounds Read in getname_kernel
Openpgp: preference=signencrypt
Autocrypt: addr=tomasbortoli@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <38c5a8ad-c192-74b9-b2ff-9eb2a3386930@gmail.com>
Date:   Mon, 2 Jul 2018 00:04:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've looked into this issue found by Syzbot and I made a patch:

https://syzkaller.appspot.com/bug?id=3Dd03abd8b42847f7f69b1d1d7f97208ae42=
5b1163


The autofs subsystem does not check that the "path" parameter is present
within the "param" struct passed by the userspace in case the
AUTOFS_DEV_IOCTL_OPENMOUNT_CMD command is passed. Indeed, it assumes a
path is always provided (though a path is not always present, as per how
the struct is defined:
https://github.com/torvalds/linux/blob/master/include/uapi/linux/auto_dev=
-ioctl.h#L89).
Skipping the check provokes an oob read in "strlen", called by
"getname_kernel", in turn called by the autofs to assess the length of
the non-existing path.

To solve it, modify the "validate_dev_ioctl" function to check also that
a path has been provided if the command is AUTOFS_DEV_IOCTL_OPENMOUNT_CMD=
=2E


--- b/fs/autofs/dev-ioctl.c=C2=A0=C2=A0=C2=A0 2018-07-01 23:10:16.0597286=
21 +0200
+++ a/fs/autofs/dev-ioctl.c=C2=A0=C2=A0=C2=A0 2018-07-01 23:10:24.3117921=
33 +0200
@@ -136,6 +136,9 @@ static int validate_dev_ioctl(int cmd, s
=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 goto out;
=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 }
=C2=A0=C2=A0=C2=A0=C2=A0 }
+=C2=A0=C2=A0=C2=A0 /* AUTOFS_DEV_IOCTL_OPENMOUNT_CMD without path */
+=C2=A0=C2=A0=C2=A0 else if(_IOC_NR(cmd) =3D=3D AUTOFS_DEV_IOCTL_OPENMOUN=
T_CMD)
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return -EINVAL;
=C2=A0
=C2=A0=C2=A0=C2=A0=C2=A0 err =3D 0;
=C2=A0out:


Tested and solves the issue on Linus' main git tree.

Tomas


