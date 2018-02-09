Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x225bd9C/sj0/BpAVRglU40DxtJKFZOTRVTWtFma5O3jFpoa4AkYYRoQ43Jstv/UBf7uiSIeN
ARC-Seal: i=1; a=rsa-sha256; t=1518184938; cv=none;
        d=google.com; s=arc-20160816;
        b=Ph3yS4gdviKu77Ip2Oa8XZ6z2s64AZwaHS7U+zu2h+EMUZaOqJi5CA88O97SI9VvBZ
         WIXw68E2i4xTliZWhTh8CpCpsAPFn3nNo+L/qnXwdH7fB2XXPZb9rFgbQCavXu3ySp5n
         ExRTyaTjyq/DwCjXqWaKrMlAiSAz+u0j569veaOzIfJ29mbtskhHghSbs1uccz3dc5Ny
         QAjdp0rFWhHKExIEnEk9gRbnTUIm5qgx0IGTLyRhwipHoq5yAeuQRFPhdBZCX2KWrK9Z
         +6yP7KhzgGGFhgQJpqaA9RCadeSfjCLKWhX2/LPxMOSNbOiC+4wpGF6frBTn0wl+Mi6a
         4Puw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:arc-authentication-results;
        bh=6D9VTELEufkLycmlkgPQCeeMvnxSibM3b5WuMG5Ej9A=;
        b=LtmFpDTIwk/tgM6FDwrZ6s9UrjHhXrnTKfUVnBsNGwtuwRgzed8eRF5uxkjys0hBEX
         ajfCtkQ6LOnJ9w0ECh6Ikr9aAexwuHA54NDEksl5HmUd0ZE0tuZ/hgv/lVlMdboe1CAf
         03zI64QBJkNlrJGlCV6s5wEk4GoCszLQK1F00nVLD9hcis/0y+NAt5YjyKwpH5bCZWkL
         cfU24v2vXe7jOPuWVAqZX28nfbRRRsWgqxE2yILik+FR31AKFvY3+NeDMJvigxirDl4w
         8ztpjKBVfJLWpE4lTBwKzJ8bS9YLGSQbT9u/0oVc9ySi3BrZAbs3g/+KjyITbldHjPrp
         ofmw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752888AbeBIOCE (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 9 Feb 2018 09:02:04 -0500
Received: from www62.your-server.de ([213.133.104.62]:38113 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbeBIOCD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Feb 2018 09:02:03 -0500
Subject: Re: [Resend] Question: kselftests: bpf/test_maps failed
To: Li Zhijian <zhijianx.li@intel.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Li, Philip" <philip.li@intel.com>
References: <747824f6-4877-69fe-9f1d-f3c18fed6a01@intel.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <40e0d564-cacb-7608-423e-eb85f5343521@iogearbox.net>
Date: Fri, 9 Feb 2018 15:01:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <747824f6-4877-69fe-9f1d-f3c18fed6a01@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591932290259842156?=
X-GMAIL-MSGID: =?utf-8?q?1591932290259842156?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/09/2018 06:14 AM, Li Zhijian wrote:
> Hi
> 
> INTEL 0-Day noticed that bpf/test_maps has different results at different platforms.
> when it fails, the details are like

Sorry for the late reply and thanks for reporting! More below:

> ------------------
>   880 Failed to create hashmap key=16 value=131072 'Cannot allocate memory'
>   881 Failed to create hashmap key=8 value=32768 'Cannot allocate memory'
>   882 Failed to create hashmap key=8 value=131072 'Cannot allocate memory'
>   883 Failed to create hashmap key=16 value=32768 'Cannot allocate memory'
>   884 Failed to create hashmap key=8 value=16384 'Cannot allocate memory'
>   885 Failed to create hashmap key=16 value=16384 'Cannot allocate memory'
>   886 Failed to create hashmap key=8 value=65536 'Cannot allocate memory'
>   887 Failed to create hashmap key=16 value=131072 'Cannot allocate memory'
>   888 Failed to create hashmap key=16 value=32768 'Cannot allocate memory'
>   889 Failed to create hashmap key=16 value=65536 'Cannot allocate memory'
>   890 Failed to create hashmap key=8 value=65536 'Cannot allocate memory'
>   891 Failed to create hashmap key=8 value=131072 'Cannot allocate memory'
>   892 Failed to create hashmap key=8 value=131072 'Cannot allocate memory'
>   893 Failed to create hashmap key=16 value=32768 'Cannot allocate memory'
>   894 Failed to create hashmap key=8 value=16384 'Cannot allocate memory'
>   895 Failed to create hashmap key=8 value=131072 'Cannot allocate memory'
>   896 Failed to create hashmap key=16 value=8192 'Cannot allocate memory'
>   897 Failed to create hashmap key=8 value=32768 'Cannot allocate memory'
>   898 Failed to create hashmap key=16 value=8192 'Cannot allocate memory'
>   899 Failed to create hashmap key=8 value=262144 'Cannot allocate memory'
>   900 Failed to create hashmap key=8 value=262144 'Cannot allocate memory'
>   901 Failed to create hashmap key=8 value=262144 'Cannot allocate memory'
>   902 Failed to create hashmap key=16 value=262144 'Cannot allocate memory'
>   903 Failed to create hashmap key=8 value=262144 'Cannot allocate memory'
>   904 Failed to create hashmap key=8 value=262144 'Cannot allocate memory'
>   905 test_maps: test_maps.c:955: run_parallel: Assertion `status == 0' failed.
>   906 Aborted
>   907 not ok 1..3 selftests:  test_maps [FAIL]
> ------------------
> 
> After a simply looking at the code, looks it's related to the cpu number and system memory.
> 
> below are the result under different platform
> 1. Good
> model: Sandy Bridge
> nr_node: 1
> nr_cpu: 4
> memory: 6G
> 
> 2. Good
> model: qemu-system-x86_64 -enable-kvm
> nr_cpu: 2
> memory: 4G
> 
> 3. Bad
> model: Ivytown Ivy Bridge-EP
> nr_cpu: 48
> memory: 64G
> 
> 4. Bad
> model: Skylake
> nr_cpu: 104
> memory: 64G
> 
> I try to change the process number to 10 from 100, so it can pass at above Skylake(4) machine.
> ------------
> lizhijian@haswell-OptiPlex-9020:~/lkp/linux/tools/testing/selftests/bpf$ git diff
> diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
> index 040356e..b788ca1 100644
> --- a/tools/testing/selftests/bpf/test_maps.c
> +++ b/tools/testing/selftests/bpf/test_maps.c
> @@ -960,7 +960,7 @@ static void test_map_stress(void)
>  {
>         run_parallel(100, test_hashmap, NULL);
>         run_parallel(100, test_hashmap_percpu, NULL);
> -       run_parallel(100, test_hashmap_sizes, NULL);
> +       run_parallel(10, test_hashmap_sizes, NULL);
>         run_parallel(100, test_hashmap_walk, NULL);
>  
>         run_parallel(100, test_arraymap, NULL);

Unless Alexei has some better idea, I think if the bpf_create_map() error in
the stress test is about ENOMEM, then we shouldn't fail hard via exit(), for
all other cases we should however. So probably makes sense to just check for
errno == ENOMEM in case of fd < 0 in test_hashmap_sizes() and then continue
to keep trying under stress. Feel free to send a patch, Li.

Thanks again,
Daniel
