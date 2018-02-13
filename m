Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x224IzXvFvA2L6Cr/1jpJVoqkK07sqeNK+UTE5QktaK2fVsveK62TsivLstLhci96hEykmVAN
ARC-Seal: i=1; a=rsa-sha256; t=1518557042; cv=none;
        d=google.com; s=arc-20160816;
        b=IDoxH2qNiBaDGTQUBGIe4ZiDtE7s6ykpRymReppVytb3CB3YE7lEdDQDjtX/zEzHMz
         GV6wRkoLu9tQLqqGbryjK6zXG6EUEvym2DaxLPUSYY+4+L5oXwQ7nUw5MvCi+G3eOg6L
         /OKBor221nZiKLc4/SR4UzIS4ky4Ih9Lr6AEjLl5RJk9yYBxkNsObTIH41HBPqGe+0qB
         PTDQJAP9wOKWbtRgqa5UQ4th38+uB2qDfpsFrub9BPWpnZ/2D1Gf6E7X7Ml7kgVv+MzW
         Ooi0aeH1KyCXJgy2dTCpQ5i15bdtgOS8+i0fvner1XOorfWLhpMaVfGKaMbW7+FO6nnS
         Y5+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:arc-authentication-results;
        bh=eWZ4ITf0TmR0N/vVosZXM6Vf6rCEfWwRpjKPW6t6W8A=;
        b=iXURybJYSFTyYGzZ+A7tDAF0+D6EP87M8XSAL+oNe0glp6DBxGWdpu578R5lIy34R6
         cGXt55WrQENSNCxgZtW2ePUsq5qRcA5Wd4Zot4TEZQ6dLU2e3ErON4xQe4yYrlI6MXlB
         OKinBlNTQ+vgvzZS6Oiuzo5FVEICdFM5/N5eY9UKgpHT1+PnbXu+vB/b1jxe6ti3IGVa
         k6um2IGARyVZvp0fs+dRRZ0AHRxQp+WfnBDoBh+nneBDfkLKbblphhUutxoqFLWXFP7N
         vzBiqd/rYz0uG0QHxS/x/oO6rM919fs0Xspcxs9CDMz074PJlE9HO5RWAJO20tOK2AT2
         WSyQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965790AbeBMVYC (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 13 Feb 2018 16:24:02 -0500
Received: from osg.samsung.com ([64.30.133.232]:57761 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965749AbeBMVYB (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Feb 2018 16:24:01 -0500
Subject: Re: [PATCH] selftests: memfd: add config fragment for fuse
To: =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>,
        linux-kselftest@vger.kernel.org
Cc: Anders Roxell <anders.roxell@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuahkh@osg.samsung.com>
References: <1517955648-11186-1-git-send-email-daniel.diaz@linaro.org>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <14ff3440-ebaf-5d1d-66a3-d6213ca4cb95@osg.samsung.com>
Date: Tue, 13 Feb 2018 14:23:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1517955648-11186-1-git-send-email-daniel.diaz@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591691916709223124?=
X-GMAIL-MSGID: =?utf-8?q?1592322469997828622?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/06/2018 03:20 PM, Daniel Díaz wrote:
> From: Anders Roxell <anders.roxell@linaro.org>
> 
> The memfd test requires to insert the fuse module (CONFIG_FUSE_FS).
> 
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> Signed-off-by: Daniel Díaz <daniel.diaz@linaro.org>
> ---
>  tools/testing/selftests/memfd/config | 1 +
>  1 file changed, 1 insertion(+)
>  create mode 100644 tools/testing/selftests/memfd/config
> 
> diff --git a/tools/testing/selftests/memfd/config b/tools/testing/selftests/memfd/config
> new file mode 100644
> index 0000000..835c7f4
> --- /dev/null
> +++ b/tools/testing/selftests/memfd/config
> @@ -0,0 +1 @@
> +CONFIG_FUSE_FS=m
> 


Thanks for the patch. Applied to linux-kselftest fixes for 4.16-rc3

thanks,
-- Shuah
