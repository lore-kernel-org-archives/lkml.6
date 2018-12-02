Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B58C64EB4
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 11:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE3A02081C
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 11:42:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE3A02081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725832AbeLBLmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 06:42:16 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38446 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725776AbeLBLmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 06:42:16 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wB2BeYuG022005
        for <linux-kernel@vger.kernel.org>; Sun, 2 Dec 2018 06:42:12 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2p482s30vp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 02 Dec 2018 06:42:12 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Sun, 2 Dec 2018 11:42:10 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 2 Dec 2018 11:42:06 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wB2Bg5cl2490862
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 2 Dec 2018 11:42:05 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C1505A4054;
        Sun,  2 Dec 2018 11:42:05 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C39AAA405B;
        Sun,  2 Dec 2018 11:42:04 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.204.137])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sun,  2 Dec 2018 11:42:04 +0000 (GMT)
Date:   Sun, 2 Dec 2018 13:42:02 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Frank Rowand <frowand.list@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@iki.fi>,
        Bart Van Assche <bvanassche@acm.org>,
        Pavel Machek <pavel@ucw.cz>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] code-of-conduct: Remove explicit list of
 discrimination factors
References: <20181202093257.3918-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181202093257.3918-1-geert@linux-m68k.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18120211-0016-0000-0000-0000022FDF88
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120211-0017-0000-0000-000032884FD1
Message-Id: <20181202114202.GD6959@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-02_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812020115
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 02, 2018 at 10:32:57AM +0100, Geert Uytterhoeven wrote:
> Providing an explicit list of discrimination factors may give the false
> impression that discrimination based on other unlisted factors would be
> allowed.
> 
> Furthermore, this list is already overly long, polarizing,
> politically-laden, and reinstating the concept of human races.
> None of these is related to the goals of the Linux kernel project.
> 
> Avoid any ambiguity or political undertone by removing the list, to
> ensure "a harassment-free experience for everyone", period.
> 
> Fixes: 8a104f8b5867c682 ("Code of Conduct: Let's revamp it.")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Frank Rowand <frowand.list@gmail.com>
> Acked-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Acked-by: Tomi Valkeinen <tomi.valkeinen@iki.fi>
> Acked-by: Bart Van Assche <bvanassche@acm.org>
> Acked-by: Pavel Machek <pavel@ucw.cz>

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
> v3:
>   - Add 2 Acked-bys,
>   - Add more rationale to the patch description.
> 
> v2:
>   - Add 3 Acked-bys.
> ---
>  Documentation/process/code-of-conduct.rst | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/Documentation/process/code-of-conduct.rst b/Documentation/process/code-of-conduct.rst
> index be50294aebd5db37..4379cce85faa804d 100644
> --- a/Documentation/process/code-of-conduct.rst
> +++ b/Documentation/process/code-of-conduct.rst
> @@ -8,10 +8,7 @@ Our Pledge
> 
>  In the interest of fostering an open and welcoming environment, we as
>  contributors and maintainers pledge to making participation in our project and
> -our community a harassment-free experience for everyone, regardless of age, body
> -size, disability, ethnicity, sex characteristics, gender identity and
> -expression, level of experience, education, socio-economic status, nationality,
> -personal appearance, race, religion, or sexual identity and orientation.
> +our community a harassment-free experience for everyone.
> 
>  Our Standards
>  =============
> -- 
> 2.17.1
> 

-- 
Sincerely yours,
Mike.

