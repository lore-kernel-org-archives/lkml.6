Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660A3C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 07:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27C9325500
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 07:07:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27C9325500
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752205AbeFYHH4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 03:07:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56534 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751238AbeFYHHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 03:07:54 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5P74KQA075700
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 03:07:54 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jtr6ky7w4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 03:07:53 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Mon, 25 Jun 2018 08:07:52 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 08:07:46 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5P77j9829163570
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Jun 2018 07:07:45 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5324A5204E;
        Mon, 25 Jun 2018 08:07:41 +0100 (BST)
Received: from mschwideX1 (unknown [9.152.212.155])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id D49E65205A;
        Mon, 25 Jun 2018 08:07:40 +0100 (BST)
Date:   Mon, 25 Jun 2018 09:07:41 +0200
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, heiko.carstens@de.ibm.com,
        john.stultz@linaro.org, sboyd@codeaurora.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        hpa@zytor.com, douly.fnst@cn.fujitsu.com, peterz@infradead.org,
        prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com,
        gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org
Subject: Re: [PATCH v12 05/11] s390/time: add
 read_persistent_wall_and_boot_offset()
In-Reply-To: <20180621212518.19914-6-pasha.tatashin@oracle.com>
References: <20180621212518.19914-1-pasha.tatashin@oracle.com>
        <20180621212518.19914-6-pasha.tatashin@oracle.com>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 18062507-0008-0000-0000-0000024B6BF2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062507-0009-0000-0000-000021B1D528
Message-Id: <20180625090741.776c8914@mschwideX1>
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-25_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806250084
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jun 2018 17:25:12 -0400
Pavel Tatashin <pasha.tatashin@oracle.com> wrote:

> read_persistent_wall_and_boot_offset() will replace read_boot_clock64()
> because on some architectures it is more convenient to read both sources
> as one may depend on the other. For s390, implementation is the same
> as read_boot_clock64() but also calling and returning value of
> read_persistent_clock64()
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> ---
>  arch/s390/kernel/time.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
> index cf561160ea88..d1f5447d5687 100644
> --- a/arch/s390/kernel/time.c
> +++ b/arch/s390/kernel/time.c
> @@ -221,6 +221,24 @@ void read_persistent_clock64(struct timespec64 *ts)
>  	ext_to_timespec64(clk, ts);
>  }
> 
> +void __init read_persistent_wall_and_boot_offset(struct timespec64 *wall_time,
> +						 struct timespec64 *boot_offset)
> +{
> +	unsigned char clk[STORE_CLOCK_EXT_SIZE];
> +	struct timespec64 boot_time;
> +	__u64 delta;
> +
> +	delta = initial_leap_seconds + TOD_UNIX_EPOCH;
> +	memcpy(clk, tod_clock_base, STORE_CLOCK_EXT_SIZE);
> +	*(__u64 *)&clk[1] -= delta;
> +	if (*(__u64 *)&clk[1] > delta)
> +		clk[0]--;
> +	ext_to_timespec64(clk, &boot_time);
> +
> +	read_persistent_clock64(wall_time);
> +	*boot_offset = timespec64_sub(*wall_time, boot_time);
> +}
> +
>  void read_boot_clock64(struct timespec64 *ts)
>  {
>  	unsigned char clk[STORE_CLOCK_EXT_SIZE];

From a s390 standpoint this looks reasonable.

Reviewed-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

