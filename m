Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFD8C43612
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFF6B20855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="Zcelj58M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbfAQLlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 06:41:52 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35467 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727724AbfAQLlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 06:41:49 -0500
Received: by mail-wm1-f68.google.com with SMTP id t200so734410wmt.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 03:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hyEw4X9ww2YPwn9o5KstPSqmqW8bN2fKms4I9AI8yZw=;
        b=Zcelj58MLCj4wOeZdWhNU/5p7yEXqvoms9YdaxxhqgX/N7PTIO+ZxnUmt3knhJlo6y
         MyAm/td1P3KZlUBZe1MRLOUO/ve6q/uQm+fpRbT0pCHCtm44RRdSBfGVdfoCmhr6V+2l
         XT/4D6AF/nm6JZlkanvJmcI+9YCMaUNZO1Nv6GCRw5lFjNNUYrJAM6A/sts2AWKyu+hj
         +ykV+yIWS1JdJWOWVoipEY9ew+HgaylXJcNQ916otiGocvfnAGIHhJZpacfEWVRH84rN
         Xd01yzj/jnsWF5nul00Y0tZkIYhp/dda4k2CLlTr0eFgsGOxpAC8VLvvSaLH1EKODlRz
         K9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hyEw4X9ww2YPwn9o5KstPSqmqW8bN2fKms4I9AI8yZw=;
        b=GeZwPCvhN3aguxIN/yYhTaIHQPiV0oayPw6pthcmj0RiKE/Q/PSDAddTtU+KWGxqW4
         7CRmnM6TLoK9o7FH8Hk1t4n1Rj0KFq3UTLzkHwPo0xxtNoVKVpzMBfGwWwXx3LmCiAnV
         9V8RKH0mHDsZ09ToGyuh4mDYbFsMwDsptg2dNFlp6AtNaY7Rg19Gps0wLJiGgQJUuYkL
         yIREOZbrXuaFRnck/igIoT2A9XTPp3LJnW8Nw2UtZgF5ZDNqsqWYz2WKAOQghURiWiao
         bmYrCGV2g/Dj05CM85i26lpumjFvXaI2JxIWJme/1tKwquEBBe7Lk4TPVk8FWOUxUNDy
         kQfA==
X-Gm-Message-State: AJcUukcVctQo4HhCdsEMYcPGe/TEYZCDPOuzeIPaqoHPOeCnPioHGFiv
        pqO6xTxvvmFL6LAv/ovcwmRsCA==
X-Google-Smtp-Source: ALg8bN6YGJYZ+w+epKhovld+BvofSEJue6KHR7OS/q2Q++zRgl5kWmTZzDzivANk9XG3yd2p4GCUCg==
X-Received: by 2002:a1c:8d12:: with SMTP id p18mr12270527wmd.31.1547725306212;
        Thu, 17 Jan 2019 03:41:46 -0800 (PST)
Received: from brauner.io ([154.119.33.254])
        by smtp.gmail.com with ESMTPSA id 129sm65249118wmd.18.2019.01.17.03.41.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 03:41:45 -0800 (PST)
Date:   Thu, 17 Jan 2019 12:41:38 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     tkjos@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        arve@android.com, maco@android.com, joel@joelfernandes.org,
        tkjos@google.com, shuah@kernel.org
Subject: Re: [PATCH v2] selftests: add binderfs selftests
Message-ID: <20190117114136.dzji6kds2ejpgq7l@brauner.io>
References: <20190117102821.10950-1-christian@brauner.io>
 <20190117105549.GA28882@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190117105549.GA28882@kroah.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 11:55:49AM +0100, Greg KH wrote:
> On Thu, Jan 17, 2019 at 11:28:21AM +0100, Christian Brauner wrote:
> > This adds the promised selftest for binderfs. It will verify the following
> > things:
> > - binderfs mounting works
> > - binder device allocation works
> > - performing a binder ioctl() request through a binderfs device works
> > - binder device removal works
> > - binder-control removal fails
> > - binderfs unmounting works
> > 
> > The tests are performed both privileged and unprivileged. The latter
> > verifies that binderfs behaves correctly in user namespaces.
> > 
> > Cc: Todd Kjos <tkjos@google.com>
> > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> 
> Now I am just nit-picking:

I would've been surprised if someone wouldn't have. :)

> 
> > +static void write_to_file(const char *filename, const void *buf, size_t count,
> > +			  int allowed_errno)
> > +{
> > +	int fd, saved_errno;
> > +	ssize_t ret;
> > +
> > +	fd = open(filename, O_WRONLY | O_CLOEXEC);
> > +	if (fd < 0)
> > +		ksft_exit_fail_msg("%s - Failed to open file %s\n",
> > +				   strerror(errno), filename);
> > +
> > +	ret = write_nointr(fd, buf, count);
> > +	if (ret < 0) {
> > +		if (allowed_errno && (errno == allowed_errno)) {
> > +			close(fd);
> > +			return;
> > +		}
> > +
> > +		goto on_error;
> > +	}
> > +
> > +	if ((size_t)ret != count)
> > +		goto on_error;
> 
> if ret < count, you are supposed to try again with the remaining data,
> right?  A write() implementation can just take one byte at a time.
> 
> Yes, for your example here that isn't going to happen as the kernel
> should be handling a larger buffer than that, but note that if you use
> this code elsewhere, it's not really correct because:

Yeah, I know you should retry but for the test I'm not really willing to
keep track of where I was in the buffer and so on. If the test fails
because of that I'd say to count it as failed and move on.

> 
> > +
> > +	close(fd);
> > +	return;
> > +
> > +on_error:
> > +	saved_errno = errno;
> 
> If you do a short write, there is no error, so who knows what errno you
> end up with here.
> 
> Anyway, just one other minor question that might be relevant:
> 
> > +	printf("Allocated new binder device with major %d, minor %d, and name %s\n",
> > +	       device.major, device.minor, device.name);
> 
> Aren't tests supposed to print their output in some sort of normal
> format?  I thought you were supposed to use ksft_print_msg() so that
> tools can properly parse the output.

I can switch the printf()s over to ksft_print_msg().

Thanks!
Christian
