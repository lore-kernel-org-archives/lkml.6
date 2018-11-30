Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0DDC04EB9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 02:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5AF8213A2
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 02:37:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5AF8213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbeK3NpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 08:45:19 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42360 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbeK3NpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 08:45:19 -0500
Received: by mail-pf1-f193.google.com with SMTP id 64so2008157pfr.9;
        Thu, 29 Nov 2018 18:37:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pV08akpReKWfPs1JXmEU10zEQpzm6oMKj8ePhQRinaA=;
        b=YnYwZSrujETeaEscIE8k3LsblAspOtqGc6k4S0lrlC0dMuolemSb9IzIgNa4PAzYre
         O7K5sSEauk9vACnjAWvXEduW23BeNJskr+2jBgBq1125rG70JRqES3qdgU5XZfs2z9xD
         AjyuQ0b7qt63yjAks/hnIVKgSl4zko721uy63M4Z4WjC23BRVRaraZAbXkq/tv/9X3GZ
         dotTj4vEZR1N5Hr9BA2bszHEU93NG1KknM/5nzkGYZbxANxBF/cQy7Eg3GGIwFmylXV+
         HfaOyL/3nxOQfn/mzyqaasMUHxJXfXTM8Y0YzWD+4jXXE44m9LXmCJWmhtIzo0mNs37S
         gKHQ==
X-Gm-Message-State: AA+aEWZJqbeUaAmxEvIiI+CB/4I6R/qQ8I3di4G2rXbNiQAz8jVB6ZxM
        fBMmdcSKK7JJNHAllfRnxxo=
X-Google-Smtp-Source: AFSGD/WmGnB4kJgY/lFfQG4xpyEN/WgRwSLEaCYoO3so4xBl4P8i2fml4bz11Ii/GWjVGMWN5zPrtQ==
X-Received: by 2002:a63:4e41:: with SMTP id o1mr2224832pgl.282.1543545457073;
        Thu, 29 Nov 2018 18:37:37 -0800 (PST)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id u69sm4791578pfj.116.2018.11.29.18.37.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 18:37:36 -0800 (PST)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Thu, 29 Nov 2018 18:37:32 -0800
Date:   Thu, 29 Nov 2018 18:37:32 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Dan Rue <dan.rue@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] selftests: firmware: remove use of non-standard diff
 -Z option
Message-ID: <20181130023732.GO4922@garbanzo.do-not-panic.com>
References: <20181127031218.24419-1-dan.rue@linaro.org>
 <20181127031218.24419-2-dan.rue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127031218.24419-2-dan.rue@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 09:12:15PM -0600, Dan Rue wrote:
> diff -Z is used to trim the trailing whitespace when comparing the
> loaded firmware file with the source firmware file. However, per the
> comment in the source code, -Z should not be necessary. In testing, the
> input and output files are identical.
> 
> Additionally, -Z is not a standard option and is not available in
> environments such as busybox. When -Z is not supported, diff fails with
> a usage error, which is suppressed, but then causes read_firmwares() to
> exit with a false failure message.

NACK -- this breaks testing on debian:

Testing with the file present...
Batched request_firmware() try #1: Files
/tmp/tmp.8GWkoSo5jZ/test-firmware.bin and
/sys/devices/virtual/misc/test_firmware/read_firmware differ
request #0: firmware was not loaded

Please add a quirks check, enable it by default, and remove it for
Busybox.

   Luis
