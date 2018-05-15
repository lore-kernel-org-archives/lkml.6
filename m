Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2422763-1526380155-2-2284621920381056736
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526380154; b=jA1zECg0FlCFsUbyFo6ZnDtplVbep9HdFE46wzm+d+oQVkQDhJ
    yMWoAM7GSYXjRm493i4fTzONL3E2T5zIYdmaZIRgewF00Sxzp0n4z+cxkSGhPKet
    ubiUz01EPA+SJSBxZbNSJ77+/kpRWVODgiVuKDVawXk5WW93xpdDSCpDmaQJPtNN
    YUu6QOqjk0cwn99uGB3IrkpPsUvAj61kI37kpcl4reTfMoLvgTOv3yJ21IgGBV0n
    5QvJs7m6puJmerSSrAkGlZ328o5zgM2WsbVdCwL92vJq2OkDxb8GEsVLeJQiWDyO
    CriE//JKLaMGITgdT0gLg7IwLDrPucy6CE0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:mime-version:content-transfer-encoding:content-type
    :references:sender:list-id; s=fm2; t=1526380154; bh=orkfMKblhGQC
    FJ/hijf6UUgaH/3b9Mcgn4/wQoNsyWQ=; b=lkhc3vWs1aq+1eZModOtiwffGnQc
    6wxIe3S3DTWd7mvz7I4NpAp2QdyEr+O5WmpADIjuYDOloYIT0mZjPDDH5iFuNnCH
    E/iqsMU1jbWruEVfuRrQY8DsqWg/l4k/jz/uNyl/q1V7d39DEiVDIXDkPTzcGgFf
    +SlxTgzd2Rtudl7lQkm4lA19SS2Dt5CFfWbHEtrVuf14fmngdGmJxlPNuuSttfCb
    bJjqNFFlDC2pHPEZf2Vt+iYFKRryV+bcqgqq5MoODmYgzPfJAnjLOaC8b+P00LPa
    O0iIUpDt2jWSEIJs0A83snim10vsUqH0swtM1PUEMyvkm/RHZvwNlhd/PA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=samsung.com header.i=@samsung.com header.b=ZQE0F19C
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=samsung.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=samsung.com header.i=@samsung.com header.b=ZQE0F19C
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=samsung.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMJG0M2VxBnDvpDXd88mEES4Ggygp5mdorIYq2agzyXTL6vyEbFSJvSReUO4yW/LfSnPArCwbD5//4UZrML3kCGGs8jo3Z0bKQXKTuSz7RODxZUMoA+H
    zFt6imMRL071BqkK4f61Fy45jD8bUg7lNHEis064XHZSXSA0ESY+5SeGFUKcL7HF259yHiET2p4GLwnAnqDDZ8gjWjOl0PnDjST4EBHDwcf6etGSdCoBy5p7
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=hD80L64hAAAA:8 a=Ndx7yIVex8M7RJDNeXoA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752774AbeEOK27 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 15 May 2018 06:28:59 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:41413 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752243AbeEOK2w (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 15 May 2018 06:28:52 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180515102848euoutp01316da37268a01316c63e01b99e953d4e~uyqPbWiOO0627806278euoutp01-
X-AuditID: cbfec7f2-1dbff70000011644-97-5afab65f645c
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Harry Wei <harryxiyou@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Roy Pledge <Roy.Pledge@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-gpio@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@zh-kernel.org, linux-usb@vger.kernel.org,
        linux-input@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-fbdev@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 11/11] docs: fix broken references with multiple
 hints
Date: Tue, 15 May 2018 12:28:46 +0200
Message-id: <9091975.Ce87WTtYpq@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <63a4f8a93f9115475bc184d0f37d076c9b9c75ff.1525870886.git.mchehab+samsung@kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUzMcRzHfX/PNWe/rugrZDvaYsqzfYd5mrXvbMbMmJuVq35i6uSui9oQ
        lTgkyiQPpSepIz06lZOOTtTRg5LcZZWHbMqO4oh0/bL13+v7+bw/3/d7n304UnqZ8eD2KiME
        lVIRKmOcqfJa+wufgPJf8gXaosXorLmOQG0pJTTqqU4AqKr+F4vSH5tpZMz8BFDLQD+DYrMK
        GfShQUegN6Z4gO4UZhEoZegmgW6cyKbQ08SvNCpJHwKo3TZIo+aKqwyKG56Nvp7pYlBmbjyJ
        ctoaCdRvO0Ug/bNMEjVVZxAo/sFjFhlOviNQi72RRC9emtk107Huug5gq8FI4ftpFhbHGd6w
        uLVyBy7Jm4uL808x+G1rFYPvDb6j8cNrOhZ3njYROCsxmcZnfgThoj49gfsNrxj8rdhzs4vc
        eWWwELo3UlDNX7XLeU9+rRGEx1CHBq78YWLALVILnDjIL4FltlJaC5w5KZ8HYGzTF1Z8fAMw
        TlvB/Fdl27oIB0v5XADvVu8TRb8B1HfHUo4Gwy+H5xPygYPd+GWwzvyEcYhIvpuFBeV3WUfD
        ld8E857YaQdTvBccTjWO1iX8HNiV3TH60WR+Ayw1JIy4cZwTHwQNxq2ixAX+TLaOSkh+JjQ8
        vEiLPA821N4BDi/IX+Rgp3kYiKnXw8aOZkJkV/jZVMqKPB02J5+mxIFYAAf1VWPLSAKwqlAq
        8gpoNDWOOUyCF8ovkY5AkJfAkyfGJBimlN0bG10LOxLPU+JWPgGY+7GHSAIz0sYFTxsXPG1c
        8AxA5gN3QaMOCxHUC5XCQV+1IkytUYb4Bu0PKwYjB/v8r8mmBwNNgTWA54BsokSfapdLaUWk
        OiqsBkCOlLlJKheNlCTBiqhoQbU/QKUJFdQ1YBpHydwl/t5H5FI+RBEh7BOEcEH1v0twTh4x
        wGWnvOHott5H5FLL5KH4A1a9pfO11S+wO91N6+3t1+S+vnQjs+nI4Qk1Sr+bfVNW2UG75lwk
        bTlUGbgoY3VUi6t/oq5oVqpPXz1+r50VYXG61VP30XN35HbfYw2tt21eW2Jcy3oPCMevsFPX
        RfsVWEH06oLvbZqEicHUlpJ2LZsjo9R7FAvnkiq14h+P7D7vrAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTYRTHed7bXofDVzN6sEgYCSWkJqFPERb0oYcgMNIPGpRDX6bpVDaV
        7EteM68UW6Ar05x3zeVd017NeW0685Kilcoy0SAVTUvTzGmB337nnN//nC+HJe2+Uw5sSHgU
        rwyXhUkZMWX80zNy+nbDpr9bf4YtyjT1EWhcU0uj2fYUgFr7N0Uor9NEI0PBPECja0sMStTp
        GTQ3UEmgyZ5kgKr0OgJptkoI9OJBIYV6s5ZpVJu3BdDEyjqNRl4/Y1DSzgm0nGFmUEFxMomK
        xocItLSSSqCmdwUkGm7PJ1Dym04REh7OEGh0Y4hEg+9NokvHcOXzSoCnBAOFm7WfRThJmBTh
        sRY/XFvqjGvKUxn8aayVwY3rMzRuy60U4en0HgLrstQ0zvgZiKsXmwi8JHxg8GrNcW9bf/GF
        ID4sJIZXunoFiIPLuw0gMo66u/Z0m4kDZWQasGIhdxYWrpiJNCBm7bhCAHO/1VP7xTaAxmE9
        ZbEY7jx8nFIOLGzPecA+UxdjkUjuqwgmqlv2Boe4a1C/OiGyMMU5wZ1swx5LuFPQXPhxb9Fh
        7iqsE1IIC1txgbC61UzuX5sHcHsp/V/AFv5ST+0FSM4RCm1P6H12hvrmHuIRsNEe0LQHNO0B
        LR+Q5cCej1Yp5AqVu4tKplBFh8tdAiMUNWD3CRq6N+qaQNrijQ7AsUBqLWnK3vC3o2UxqlhF
        B4AsKbWXtLjvtiRBsth7vDLitjI6jFd1gKMsJT0iGXSL9bfj5LIoPpTnI3nl/ynBWjnEgfz6
        KwkRpazRN8d02dpt9I7OxfucWK+ZHLbtNeYsL8zOm31cNRejmbIKpKw7aWysf+UlF6gtq+Yv
        HjeDTfedfK8XG2ZChZEutfDjd/wyj/1iEhYC5jx1jS+D3lrb0PYlAxKjKb5qMMo1M2d9uijY
        04e9ZRpfna6IrZqcc/SVUqpg2RlnUqmS/QUogIluAAMAAA==
X-CMS-MailID: 20180515102847eucas1p15466ad147e8836cad2dc3f2ef5044c79
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180509131942epcas2p3b11ff686acaa5e3d9afedef1a2a03aa7
X-RootMTR: 20180509131942epcas2p3b11ff686acaa5e3d9afedef1a2a03aa7
References: <cover.1525870886.git.mchehab+samsung@kernel.org>
        <CGME20180509131942epcas2p3b11ff686acaa5e3d9afedef1a2a03aa7@epcas2p3.samsung.com>
        <63a4f8a93f9115475bc184d0f37d076c9b9c75ff.1525870886.git.mchehab+samsung@kernel.org>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wednesday, May 09, 2018 10:18:54 AM Mauro Carvalho Chehab wrote:
> The script:
> 	./scripts/documentation-file-ref-check --fix-rst
> 
> Gives multiple hints for broken references on some files.
> Manually use the one that applies for some files.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com> # for fbdev part

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

