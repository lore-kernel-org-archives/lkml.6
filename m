Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x224nuazKjONQMIaO8FG1czxko5SUbcSwXSL01kmHzrBzXcqp0do8eKJb7C6KdlKfCk8jpW4S
ARC-Seal: i=1; a=rsa-sha256; t=1518458312; cv=none;
        d=google.com; s=arc-20160816;
        b=DPlWtO5QSdbsHksz1rYxIoKIjSFi8BRj83b9v/pIrOZPHP76mVVh0r/lDwVIPOLTZA
         FbZNWOODCcyNuZh4b89Um2Fg4LzjtbvBOAvrrIchtEH51C/HDrToHUzLWoW8Nhb9ftU1
         teeIBwPkyEPiChF/86EuBft9054dlZcVu/qmBUOJIPBeRbIiQOMvEgGvpU2B3nOB41kD
         4MxxoFSBGYrs/MbbwAtWRIc0Y3YKU1zlNv0lQNRWY814nX/N6GfS0XaD6bQhq/TfIgRW
         ugtjfUwntA+P+N6YhssNgHhqqV6PdBoENqmWK3ljiV0Qu5gGnYA2dIKJJbUsl966vTmX
         T/hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:reply-to
         :arc-authentication-results;
        bh=9m00GC/4Fr0+25VW364Q82TJI9P81FeKzUteK6T3fGU=;
        b=rSfWH8UvwEcdSyqafsFt+kGX95hW4Cc+RAjUZwLgrOxSjY2r7oM3GbAXo/Vq6c8TEa
         pdcFwKhxtRqIPUnRJeXZW0RwZofUi0c7KXoqUVXdJhXD2h7b0aeDoAQzE0JvN3ewv/ji
         SlkfxoO75qXBDk0abjNewZh7zKR5s+PuS4h7MkxqCrXtilNoa1P8ER5phgtU2FKvgHe9
         1zOVnhK8JPh9Izs1sEEY/YJHANHmpg7kdW1H+EXzWJFIQPnmNPK2nQQa65Eb4PfaV+lp
         65kQSu/9To9rMhPOUF+sn7JdLxn3Jlmdvz4utwgAC+OrDg/dd37zrWOHVfVhSNIkaEos
         nZFg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753644AbeBLR6b (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Mon, 12 Feb 2018 12:58:31 -0500
Received: from mailout.easymail.ca ([64.68.200.34]:45464 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753620AbeBLR6a (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Feb 2018 12:58:30 -0500
Reply-To: shuah@kernel.org
Subject: Re: [PATCH] selftests/x86: clarify that there is no buffer overflow
 on sscanf usage
To: Dominik Brodowski <linux@dominikbrodowski.net>,
        Ingo Molnar <mingo@kernel.org>, linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
        Andrew Lutomirski <luto@kernel.org>,
        Shuah Khan <shuahkh@osg.samsung.com>,
        Shuah Khan <shuah@kernel.org>
References: <20180211111013.16888-1-linux@dominikbrodowski.net>
 <20180211111013.16888-3-linux@dominikbrodowski.net>
 <20180211112153.f2ni5mcuut6f6zvq@gmail.com>
 <20180211121714.GA11096@isilmar-4.linta.de>
 <20180211130029.GA23754@light.dominikbrodowski.net>
 <20180211182428.e7isprkt6hbuq3dk@gmail.com>
 <20180211205924.GA23210@light.dominikbrodowski.net>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <14b56564-cfa0-e6aa-7f5d-57431be7eb03@kernel.org>
Date: Mon, 12 Feb 2018 10:58:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180211205924.GA23210@light.dominikbrodowski.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592140147310711169?=
X-GMAIL-MSGID: =?utf-8?q?1592218943670022591?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/11/2018 01:59 PM, Dominik Brodowski wrote:
> 
> Suggested-by: Ingo Molnar <mingo@kernel.org>
> CC: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
> 

Missing commit log. Please add one.

thanks,
-- Shuah

> ---
> 
>> Yeah, probably - but still, this connection and the sscanf() guarantee is not 
>> obvious at first sight, so please improve this to derive from the same value 
>> (define a LINE_MAX size or such), plus maybe add a comment to the sscanf() line 
>> that this is safe because strlen(name) >= strlen(line).
> 
> Sounds reasonable. Patch (which applies on top of the five patches for
> selftests/x86 I sent out earlier today) is attached.
> 
> Thanks,
> 	Dominik
> 
> diff --git a/tools/testing/selftests/x86/test_vdso.c b/tools/testing/selftests/x86/test_vdso.c
> index 558c8207e7b9..7ade625f10ed 100644
> --- a/tools/testing/selftests/x86/test_vdso.c
> +++ b/tools/testing/selftests/x86/test_vdso.c
> @@ -26,6 +26,9 @@
>  # endif
>  #endif
>  
> +/* max length of lines in /proc/self/maps - anything longer is skipped here */
> +#define MAPS_LINE_LEN 128
> +
>  int nerrs = 0;
>  
>  typedef long (*getcpu_t)(unsigned *, unsigned *, void *);
> @@ -37,17 +40,19 @@ static void *vsyscall_getcpu(void)
>  {
>  #ifdef __x86_64__
>  	FILE *maps;
> -	char line[128];
> +	char line[MAPS_LINE_LEN];
>  	bool found = false;
>  
>  	maps = fopen("/proc/self/maps", "r");
>  	if (!maps) /* might still be present, but ignore it here, as we test vDSO not vsyscall */
>  		return NULL;
>  
> -	while (fgets(line, sizeof(line), maps)) {
> +	while (fgets(line, MAPS_LINE_LEN, maps)) {
>  		char r, x;
>  		void *start, *end;
> -		char name[128];
> +		char name[MAPS_LINE_LEN];
> +
> +		/* sscanf is safe here as strlen(name) >= strlen(line) */
>  		if (sscanf(line, "%p-%p %c-%cp %*x %*x:%*x %*u %s",
>  			   &start, &end, &r, &x, name) != 5)
>  			continue;
> diff --git a/tools/testing/selftests/x86/test_vsyscall.c b/tools/testing/selftests/x86/test_vsyscall.c
> index 7a744fa7b786..ee92e4727f18 100644
> --- a/tools/testing/selftests/x86/test_vsyscall.c
> +++ b/tools/testing/selftests/x86/test_vsyscall.c
> @@ -33,6 +33,9 @@
>  # endif
>  #endif
>  
> +/* max length of lines in /proc/self/maps - anything longer is skipped here */
> +#define MAPS_LINE_LEN 128
> +
>  static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
>  		       int flags)
>  {
> @@ -98,7 +101,7 @@ static int init_vsys(void)
>  #ifdef __x86_64__
>  	int nerrs = 0;
>  	FILE *maps;
> -	char line[128];
> +	char line[MAPS_LINE_LEN];
>  	bool found = false;
>  
>  	maps = fopen("/proc/self/maps", "r");
> @@ -108,10 +111,12 @@ static int init_vsys(void)
>  		return 0;
>  	}
>  
> -	while (fgets(line, sizeof(line), maps)) {
> +	while (fgets(line, MAPS_LINE_LEN, maps)) {
>  		char r, x;
>  		void *start, *end;
> -		char name[128];
> +		char name[MAPS_LINE_LEN];
> +
> +		/* sscanf is safe here as strlen(name) >= strlen(line) */
>  		if (sscanf(line, "%p-%p %c-%cp %*x %*x:%*x %*u %s",
>  			   &start, &end, &r, &x, name) != 5)
>  			continue;
> 
> 

