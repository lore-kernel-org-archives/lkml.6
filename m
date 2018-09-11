Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D03C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8446320866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:00:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8446320866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=barracuda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbeIKSAE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 14:00:04 -0400
Received: from esg-scl.cuda-inc.com ([64.235.144.189]:39206 "EHLO
        esg-mdw.barracuda.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727022AbeIKSAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 14:00:03 -0400
X-ASG-Debug-ID: 1536669673-0e7bdd16461e3dd0001-xx1T2L
Received: from IP-SCL-EXCH03.ad.cuda-inc.com (ip-scl-exch03.cuda-inc.com [10.8.96.79]) by esg-mdw.barracuda.com with ESMTP id Gxk3H0F5n2sBE0Zf (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 11 Sep 2018 05:41:13 -0700 (PDT)
X-Barracuda-Envelope-From: jkuhn@barracuda.com
Received: from IP-SCL-EXCH03.ad.cuda-inc.com (10.8.96.79) by
 IP-SCL-EXCH03.ad.cuda-inc.com (10.8.96.79) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 11 Sep 2018 05:41:12 -0700
Received: from IP-SCL-EXCH03.ad.cuda-inc.com ([fe80::9d40:a4ad:9cb9:4f89]) by
 IP-SCL-EXCH03.ad.cuda-inc.com ([fe80::9d40:a4ad:9cb9:4f89%13]) with mapi id
 15.00.1367.000; Tue, 11 Sep 2018 05:41:12 -0700
From:   Jon Kuhn <jkuhn@barracuda.com>
To:     Steve French <smfrench@gmail.com>
CC:     Steve French <sfrench@samba.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs/cifs: don't translate SFM_SLASH (U+F026) to backslash
Thread-Topic: [PATCH] fs/cifs: don't translate SFM_SLASH (U+F026) to backslash
X-ASG-Orig-Subj: Re: [PATCH] fs/cifs: don't translate SFM_SLASH (U+F026) to backslash
Thread-Index: AQHUF5HZXtDdJMgrUkqoXJQp1BnF3qTTlDMAgBfOhd0=
Date:   Tue, 11 Sep 2018 12:41:11 +0000
Message-ID: <1536669671991.92366@barracuda.com>
References: <20180709143314.4378-1-jkuhn@barracuda.com>,<CAH2r5muQXJFzut4upVAk-nTFv3qGGOaG+QKLkGgqGA1HitUMGg@mail.gmail.com>
In-Reply-To: <CAH2r5muQXJFzut4upVAk-nTFv3qGGOaG+QKLkGgqGA1HitUMGg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.26.137.144]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Barracuda-Connect: ip-scl-exch03.cuda-inc.com[10.8.96.79]
X-Barracuda-Start-Time: 1536669673
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA384
X-Barracuda-URL: https://esg-scl.cuda-inc.com:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Virus-Scanned: by bsmtpd at barracuda.com
X-Barracuda-Scan-Msg-Size: 4310
X-Barracuda-Spam-Score: 0.23
X-Barracuda-Spam-Status: No, SCORE=0.23 using per-user scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=SH_BIG5_05413_BODY_104, THREAD_INDEX, THREAD_TOPIC
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.57351
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.01 THREAD_TOPIC           Thread-Topic: ...(Japanese Subject)...
        0.01 THREAD_INDEX           thread-index: AcO7Y8iR61tzADqsRmmc5wNiFHEOig==
        0.21 SH_BIG5_05413_BODY_104 BODY: Body: contain "UNSUBSCRIBE"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do you have specific scenarios you'd like to see tested?

I created files containing the following characters on a 
Windows 2012 R2 file server from an OS X 10.13.4 client:

    back slash (translates to U+F026)
    forward slash (translates to U+F022)
    greater than (translates to U+F024)
    less than (translates to U+F023)
    pipe (translates to U+F027)
    question mark (translates to U+F025)
    asterisk (translates to U+F021)

I then mounted the file server from an Ubuntu 18.04 LTS (kernel 4.15.20)
machine (normally without the -o mapchars option).

Before my change, all files except the one containing the backslash could
be opened using the name they are given when you list the directory.  The
backslash was represented as a literal backslash in directory listings, but
could not be opened using that name.

After my change, all files can be opened using the name they are given
when you list the directory.  However, the backslash is represented as
U+F026 in the directory listing since I removed the translation.

I think this change makes the SFM_SLASH behavior consistent
with the UNI_SLASH behavior, since there is a comment in
convert_sfu_char() that states:

	/*
	 * BB: Cannot handle remapping UNI_SLASH until all the calls to
	 *     build_path_from_dentry are modified, as they use slash as
	 *     separator.
	 */

________________________________________
From: Steve French <smfrench@gmail.com>
Sent: Sunday, August 26, 2018 9:40 PM
To: Jon Kuhn
Cc: Steve French; CIFS; samba-technical; LKML
Subject: Re: [PATCH] fs/cifs: don't translate SFM_SLASH (U+F026) to backslash

Tentatively merged into cifs-2.6.git for-next but would like a little
more experimentation with it if possible (or description of what
scenarios/servers have been tried)
On Mon, Jul 9, 2018 at 9:53 AM Jon Kuhn <jkuhn@barracuda.com> wrote:
>
> When a Mac client saves an item containing a backslash to a file server
> the backslash is represented in the CIFS/SMB protocol as as U+F026.
> Before this change, listing a directory containing an item with a
> backslash in its name will return that item with the backslash
> represented with a true backslash character (U+005C) because
> convert_sfm_character mapped U+F026 to U+005C when interpretting the
> CIFS/SMB protocol response.  However, attempting to open or stat the
> path using a true backslash will result in an error because
> convert_to_sfm_char does not map U+005C back to U+F026 causing the
> CIFS/SMB request to be made with the backslash represented as U+005C.
>
> This change simply prevents the U+F026 to U+005C conversion from
> happenning.  This is analogous to how the code does not do any
> translation of UNI_SLASH (U+F000).
>
> Signed-off-by: Jon Kuhn <jkuhn@barracuda.com>
> ---
>  fs/cifs/cifs_unicode.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/fs/cifs/cifs_unicode.c b/fs/cifs/cifs_unicode.c
> index b380e087..a2b2355e 100644
> --- a/fs/cifs/cifs_unicode.c
> +++ b/fs/cifs/cifs_unicode.c
> @@ -105,9 +105,6 @@ convert_sfm_char(const __u16 src_char, char *target)
>         case SFM_LESSTHAN:
>                 *target = '<';
>                 break;
> -       case SFM_SLASH:
> -               *target = '\\';
> -               break;
>         case SFM_SPACE:
>                 *target = ' ';
>                 break;
> --
> 2.17.1
>
>
> ===========================================================
> Learn how to protect users, data, and applications with security engineered for the public cloud by Barracuda. http://barracuda.com
>
> DISCLAIMER:
> This e-mail and any attachments to it contain confidential and proprietary material of Barracuda, its affiliates or agents, and is solely for the use of the intended recipient. Any review, use, disclosure, distribution or copying of this transmittal is prohibited except by or on behalf of the intended recipient. If you have received this transmittal in error, please notify the sender and destroy this e-mail and any attachments and all copies, whether electronic or printed.
> ===========================================================
> --
> To unsubscribe from this list: send the line "unsubscribe linux-cifs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--
Thanks,

Steve

===========================================================
Forrester names Barracuda WAF a Strong Performer!
Get the free report here!
https://www.barracuda.com/WAFWave

DISCLAIMER:
This e-mail and any attachments to it contain confidential and proprietary material of Barracuda, its affiliates or agents, and is solely for the use of the intended recipient. Any review, use, disclosure, distribution or copying of this transmittal is prohibited except by or on behalf of the intended recipient. If you have received this transmittal in error, please notify the sender and destroy this e-mail and any attachments and all copies, whether electronic or printed.
===========================================================
