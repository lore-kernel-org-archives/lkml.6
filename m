Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA43C169D4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8217A205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:54:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8217A205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbeJPWox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:44:53 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:60562 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbeJPWow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:44:52 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 625304121C;
        Tue, 16 Oct 2018 14:53:53 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo03-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JUpqwOlau4S7; Tue, 16 Oct 2018 14:53:53 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id EA22940F59;
        Tue, 16 Oct 2018 14:53:45 +0000 (UTC)
Subject: Re: [PATCH] selftests: fix warning: "_GNU_SOURCE" redefined
To:     Peng Hao <peng.hao2@zte.com.cn>, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <1539287630-92982-1-git-send-email-peng.hao2@zte.com.cn>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <5dbfc86b-17f9-4f56-ebaa-489f70436294@kernel.org>
Date:   Tue, 16 Oct 2018 08:53:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1539287630-92982-1-git-send-email-peng.hao2@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/2018 01:53 PM, Peng Hao wrote:
> Makefile contains -D_GNU_SOURCE. remove define "_GNU_SOURCE"
> in c files.
> 
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  tools/testing/selftests/proc/fd-001-lookup.c  | 2 +-
>  tools/testing/selftests/proc/fd-003-kthread.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/proc/fd-001-lookup.c b/tools/testing/selftests/proc/fd-001-lookup.c
> index a2010df..60d7948 100644
> --- a/tools/testing/selftests/proc/fd-001-lookup.c
> +++ b/tools/testing/selftests/proc/fd-001-lookup.c
> @@ -14,7 +14,7 @@
>   * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
>   */
>  // Test /proc/*/fd lookup.
> -#define _GNU_SOURCE
> +
>  #undef NDEBUG
>  #include <assert.h>
>  #include <dirent.h>
> diff --git a/tools/testing/selftests/proc/fd-003-kthread.c b/tools/testing/selftests/proc/fd-003-kthread.c
> index 1d659d5..dc591f9 100644
> --- a/tools/testing/selftests/proc/fd-003-kthread.c
> +++ b/tools/testing/selftests/proc/fd-003-kthread.c
> @@ -14,7 +14,7 @@
>   * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
>   */
>  // Test that /proc/$KERNEL_THREAD/fd/ is empty.
> -#define _GNU_SOURCE
> +
>  #undef NDEBUG
>  #include <sys/syscall.h>
>  #include <assert.h>
> 

Thanks for the patch. Applied to linux-kselftest next for 4.20-rc1.

thanks,
-- Shuah
