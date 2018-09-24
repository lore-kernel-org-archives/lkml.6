Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD3AECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77B0A2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hjq8iD3s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77B0A2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbeIXQAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 12:00:23 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37186 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728057AbeIXQAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 12:00:23 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8O9sP7d075508;
        Mon, 24 Sep 2018 09:58:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=E8zZ9mrkLaw2xTRBwTkp0jjl/a1Ed3CFZ2TcgCS9Qag=;
 b=hjq8iD3sYdjfjYAjewje43Z3WkJIbRauYDgTFbR66cyKx67fKh7kL1RUxh5yux/GW7p5
 A2jLrz5XRD6hb5SWnYRdQQtbpoWg34ZzxhZjb+x27S2JCERzQ5mPjF0tnm5QHql//GJS
 I55toW/PoJ52tf1rypbNQ8cnSFS3VDoTAroicuoJ5QlgSXcwSbi+W80VxEYKRN0K1XsX
 EhQuYMzoE2yLxUOKZqwB49o7zY4jR/qWDHq/OgylyAlJD86/4pu2zWT7UNXR5fUGSlP0
 /JET/YLQT9lVP1BVT+NJCHg6CsW7I281C7eeS9keRv2xrXq5vV/5qiTU0mD933R5aTHT rA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2mnd5t4qv0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Sep 2018 09:58:33 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8O9wRok031343
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Sep 2018 09:58:28 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8O9wQiB021735;
        Mon, 24 Sep 2018 09:58:26 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Sep 2018 02:58:26 -0700
Date:   Mon, 24 Sep 2018 12:58:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Aymen Qader <qader.aymen@gmail.com>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>, devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 4/5] staging: vc04_services: Surround complex macros
Message-ID: <20180924095819.q3zsqspddxjlsc2e@mwanda>
References: <20180923140620.14583-1-qader.aymen@gmail.com>
 <20180923140620.14583-5-qader.aymen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180923140620.14583-5-qader.aymen@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9025 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=649
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809240106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 23, 2018 at 03:06:19PM +0100, Aymen Qader wrote:
> This patch fixes the checkpatch.pl error:
> 
> ERROR: Macros with complex values should be enclosed in parentheses
> 
> in the interface/vchi directory
> 
> Signed-off-by: Aymen Qader <qader.aymen@gmail.com>
> ---
>  drivers/staging/vc04_services/interface/vchi/vchi.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/vc04_services/interface/vchi/vchi.h b/drivers/staging/vc04_services/interface/vchi/vchi.h
> index d8e660240a44..f818cf2e27e1 100644
> --- a/drivers/staging/vc04_services/interface/vchi/vchi.h
> +++ b/drivers/staging/vc04_services/interface/vchi/vchi.h
> @@ -92,14 +92,14 @@ typedef struct vchi_msg_vector_ex {
>  } VCHI_MSG_VECTOR_EX_T;
>  
>  // Construct an entry in a msg vector for a pointer (p) of length (l)
> -#define VCHI_VEC_POINTER(p, l)  VCHI_VEC_POINTER, { { (VCHI_MEM_HANDLE_T)(p), (l) } }
> +#define VCHI_VEC_POINTER(p, l)  (VCHI_VEC_POINTER, { { (VCHI_MEM_HANDLE_T)(p), (l) } })
>  
>  // Construct an entry in a msg vector for a message handle (h), starting at offset (o) of length (l)
> -#define VCHI_VEC_HANDLE(h, o, l) VCHI_VEC_HANDLE,  { { (h), (o), (l) } }
> +#define VCHI_VEC_HANDLE(h, o, l) (VCHI_VEC_HANDLE,  { { (h), (o), (l) } })
>  
>  // Macros to manipulate 'FOURCC' values
>  #define MAKE_FOURCC(x) ((int32_t)((x[0] << 24) | (x[1] << 16) | (x[2] << 8) | x[3]))
> -#define FOURCC_TO_CHAR(x) (x >> 24) & 0xFF, (x >> 16) & 0xFF, (x >> 8) & 0xFF, x & 0xFF
> +#define FOURCC_TO_CHAR(x) ((x >> 24) & 0xFF, (x >> 16) & 0xFF, (x >> 8) & 0xFF, x & 0xFF)
>  

These are never used so far as I can see, but if they were, then this
would probably break the code.  Go through the git log and find out how
they used to work and if they can be removed.

regards,
dan carpenter

