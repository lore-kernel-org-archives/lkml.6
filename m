Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB179C7112C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 13:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2CBB2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 13:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7Qbpjfs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2CBB2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbeJXWL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 18:11:58 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37439 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbeJXWL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 18:11:58 -0400
Received: by mail-wr1-f65.google.com with SMTP id g9-v6so5658680wrq.4;
        Wed, 24 Oct 2018 06:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dNJtO6i3Kfvf1KktXEna8GrGSbj5XeMGVArGLLH9Iwk=;
        b=D7Qbpjfs83TTGaTKXLLfoV9nMNNXmCTAscxOF5Z42z1oNXFMhuLoGfe1XT5+mkPX2g
         FyUjTyIGZJDtnwkRTezwdphbBLQ9liGuLgBA8VnDTM1SIxSQwO98/+XYpH2EaSLgUUkr
         rqkhrtT4T4a/khzjB4whJL9PMvLUCWXMGDiz9LxzyKYvbpoot2DLYo3F42X41rPuBVmq
         r1ge3kHV1J7VIjRzZ3VEmpXDlBnSrFvhP5R9tpidAmBdaQNONznHGzuekmkh4R+yOMc0
         rlY47qBRQkV+VvO/5rjZulEd/5wvTbL2mRqnfmTpztn5RpPNiMe9k6mYnkOjDPM8aJOr
         9/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dNJtO6i3Kfvf1KktXEna8GrGSbj5XeMGVArGLLH9Iwk=;
        b=uLnq4YehmBAti4uW2SbJMNvR/Qpzxuw/vXOuMtTLC4bsyZi7nF1KG3Qe6Omc3l+QL0
         yHzmUiQbKU4Nb2pe70r6mTd3ElEtfHRKbNo3LeAQPop3xI4w/s/bBel2f3FJpr1m3RW3
         ALTImTkiTdGndDnQ7VJ52BJ9LgKWPFSWxN07F6vTrK4Lf0oFu04tw49p4lpk0aLnjHnB
         xlP6QafLm8KhGy4zMC9qHanUN3QUp4AuLdLtTLMf9SYokhYmsGpNWVhwnVePSIzCHmpM
         ObJ9hdUK85jJk5MsLtoek46xXQpnEy2U9USc4sxoWyQBxWBfgjELzTJMDSz2u8hwAsIk
         FyjQ==
X-Gm-Message-State: AGRZ1gJuqLYxgFiQ2xZliABIw0KcQXlLlCSVv9CrFEH8nC/scCvqHg6J
        C4jw/JD3Khq4Cp90hopmzQ==
X-Google-Smtp-Source: AJdET5fl9VwfAPxKCK3bVYvE4u89Qilo/202VZ7Wn9iu+eHOMop3IqLiin8QfIt6E62WlAHIgRTj4A==
X-Received: by 2002:adf:9592:: with SMTP id p18-v6mr3145316wrp.202.1540388626661;
        Wed, 24 Oct 2018 06:43:46 -0700 (PDT)
Received: from avx2 (nat5-minsk-pool-46-53-217-92.telecom.by. [46.53.217.92])
        by smtp.gmail.com with ESMTPSA id m16sm3812393wrx.75.2018.10.24.06.43.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 06:43:45 -0700 (PDT)
Date:   Wed, 24 Oct 2018 16:43:43 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Igor Stoppa <igor.stoppa@gmail.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        kernel-hardening@lists.openwall.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, igor.stoppa@huawei.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Pekka Enberg <penberg@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Lihao Liang <lianglihao@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/17] prmem: linked list: disable layout randomization
Message-ID: <20181024134343.GA7767@avx2>
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
 <20181023213504.28905-14-igor.stoppa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181023213504.28905-14-igor.stoppa@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 12:35:00AM +0300, Igor Stoppa wrote:
> Some of the data structures used in list management are composed by two
> pointers. Since the kernel is now configured by default to randomize the
> layout of data structures soleley composed by pointers,

Isn't this true for function pointers?
