Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB75EC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 772EC20849
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:23:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 772EC20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933907AbeGBJXi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 05:23:38 -0400
Received: from smtp-out6.electric.net ([192.162.217.185]:63645 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933829AbeGBJXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 05:23:34 -0400
Received: from 1fZv3T-0000gQ-Uu by out6a.electric.net with emc1-ok (Exim 4.90_1)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1fZv3U-0000my-VJ; Mon, 02 Jul 2018 02:23:32 -0700
Received: by emcmailer; Mon, 02 Jul 2018 02:23:32 -0700
Received: from [156.67.243.126] (helo=AcuMS.aculab.com)
        by out6a.electric.net with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1fZv3T-0000gQ-Uu; Mon, 02 Jul 2018 02:23:31 -0700
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 2 Jul 2018 10:25:11 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 2 Jul 2018 10:25:11 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Taeung Song' <treeze.taeung@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
CC:     Teng Qin <qinteng@fb.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/4] samples/bpf: Check the error of write() and read()
Thread-Topic: [PATCH 3/4] samples/bpf: Check the error of write() and read()
Thread-Index: AQHUEeXT5Bh7AKk1jEeTWRWtKGH1caR7qFeA
Date:   Mon, 2 Jul 2018 09:25:11 +0000
Message-ID: <c8fd15978e6642158c7e64190e4dee13@AcuMS.aculab.com>
References: <1530522893-8961-1-git-send-email-treeze.taeung@gmail.com>
 <1530522893-8961-4-git-send-email-treeze.taeung@gmail.com>
In-Reply-To: <1530522893-8961-4-git-send-email-treeze.taeung@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Outbound-IP: 156.67.243.126
X-Env-From: David.Laight@ACULAB.COM
X-Proto: esmtps
X-Revdns: 
X-HELO: AcuMS.aculab.com
X-TLS:  TLSv1.2:ECDHE-RSA-AES256-SHA384:256
X-Authenticated_ID: 
X-PolicySMART: 3396946, 3397078
X-Virus-Status: Scanned by VirusSMART (c)
X-Virus-Status: Scanned by VirusSMART (s)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Taeung Song
> Sent: 02 July 2018 10:15
> test_task_rename() and test_urandom_read()
> can be failed during write() and read(),
> So check the result of them.
> 
> Signed-off-by: Taeung Song <treeze.taeung@gmail.com>
> ---
>  samples/bpf/test_overhead_user.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/samples/bpf/test_overhead_user.c b/samples/bpf/test_overhead_user.c
> index 6caf47a..8a88d9c 100644
> --- a/samples/bpf/test_overhead_user.c
> +++ b/samples/bpf/test_overhead_user.c
> @@ -6,6 +6,7 @@
>   */
>  #define _GNU_SOURCE
>  #include <sched.h>
> +#include <errno.h>
>  #include <stdio.h>
>  #include <sys/types.h>
>  #include <asm/unistd.h>
> @@ -44,8 +45,12 @@ static void test_task_rename(int cpu)
>  		exit(1);
>  	}
>  	start_time = time_get_ns();
> -	for (i = 0; i < MAX_CNT; i++)
> -		write(fd, buf, sizeof(buf));
> +	for (i = 0; i < MAX_CNT; i++) {
> +		if (write(fd, buf, sizeof(buf)) < 0) {
> +			printf("task rename failed: %s\n", strerror(errno));
> +			break;

I'm not sure 'break' generates sensible output.

> +		}
> +	}

What about partial writes??

>  	printf("task_rename:%d: %lld events per sec\n",
>  	       cpu, MAX_CNT * 1000000000ll / (time_get_ns() - start_time));
>  	close(fd);
> @@ -55,7 +60,7 @@ static void test_urandom_read(int cpu)
>  {
>  	__u64 start_time;
>  	char buf[4];
> -	int i, fd;
> +	int i, fd, err = 0;
> 
>  	fd = open("/dev/urandom", O_RDONLY);
>  	if (fd < 0) {
> @@ -63,8 +68,13 @@ static void test_urandom_read(int cpu)
>  		exit(1);
>  	}
>  	start_time = time_get_ns();
> -	for (i = 0; i < MAX_CNT; i++)
> -		read(fd, buf, sizeof(buf));
> +	for (i = 0; i < MAX_CNT; i++) {
> +		err = read(fd, buf, sizeof(buf));
> +		if (err < 0 || err >= sizeof(buf)) {

Overlong reads indicate that something is seriously awry.
Short reads are valid - but maybe not expected.
> +			printf("failed to read from /dev/urandom: %s\n", strerror(errno));


strerror() won't give anything sensible unless err == -1;
You probably want to include the loop count.

> +			break;

The summary print will be gibberish after break.

> +		}
> +	}
>  	printf("urandom_read:%d: %lld events per sec\n",
>  	       cpu, MAX_CNT * 1000000000ll / (time_get_ns() - start_time));
>  	close(fd);
> --
> 2.7.4

