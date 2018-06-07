Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id wXz5CmB1GVuYCwAAmS7hNA
	; Thu, 07 Jun 2018 18:12:45 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0DDB0608BF; Thu,  7 Jun 2018 18:12:45 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="jvmtWObt"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6A8A8605A2;
	Thu,  7 Jun 2018 18:12:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6A8A8605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935228AbeFGSMm (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 14:12:42 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52410 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933625AbeFGSMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 14:12:38 -0400
Received: by mail-wm0-f66.google.com with SMTP id p126-v6so19705961wmb.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 11:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/noWcpvMlvXKQtYeb+9JnZMxGCVSaMnGNzNS8Eaw8fE=;
        b=jvmtWObtN9VfAPAj+0RZYkFyvhiHWBfG3DyNdUR2L4Dif5CEWJc4SJMTE9lWv7+GXj
         C6eadtK18FI1lx8fW93DIYJMaO4Xh0vc5AT0Fb15mOcy8No/KYhOxp7nMV043wpoF3BZ
         2/k9VslmUMbSkaNP7PS2ArCHcX+a9zlyrlCy8ixiQuLhOtd6CcgmUh023IRDWz3V2XGr
         TfTRZfGOhHFdyWT+E56j6JeZ0W3bjiLRjqKXQ0lDNzgatIPCO/b91sTot4EcI4XsaUmZ
         t+MrzmJ4XKacZvnqAfWz+4V9NhGQxnWDptLZby8WntuSEVpPi/ScjUAJnW6RcKletIMS
         w/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/noWcpvMlvXKQtYeb+9JnZMxGCVSaMnGNzNS8Eaw8fE=;
        b=Z9yn6rHo77YG5P6jC6bZuJhGCs4OMHI/tNZ/pCpeb7NGgG8YcA09QuXipsFNNCatlS
         yoBVvge5GVL87UpGLz0W5f7sxdIKSqmk+Wva6TAZ71IiLYKFrFEBNd6BAMsvJbq291Qr
         CH7SvYiD3NN62E1r9vb7OhR671VPo7eFbVHlcibYHdXrv7qn5XregUVVHBWtFcjuzWnp
         ezS2DT6u1ZC3Fso3t7V8oX5KB5LPAYL9nRVzUFB6tMg5f17WbB5su5JTmbxwGGB3lCMv
         hGSSgAGWizekwI4RGSL8xvsG6OkNZAIopVJ1pbKzGNpI1KzmAIhqrwN5Cfv+FKFtGJMc
         dEIA==
X-Gm-Message-State: APt69E1RSJVUCPjr+aQUHIXoOLNZH3cHE3BewLYx9OPbxnABVha9z4MJ
        Fdao4btTAqVvV+9FpJahK8Ah6w==
X-Google-Smtp-Source: ADUXVKJ0og2nrhF1uFgZizyCgn+XSPZBTb8kIpfEkbbBkl6zfGh8fNLFGaMBUjX7euBnuAGV/zkGsA==
X-Received: by 2002:a50:aa2f:: with SMTP id o44-v6mr3648787edc.186.1528395157229;
        Thu, 07 Jun 2018 11:12:37 -0700 (PDT)
Received: from netronome.com (penelope-musen.amstelveen.horms.nl. [2001:470:7eb3:404:c685:8ff:fe7c:9971])
        by smtp.gmail.com with ESMTPSA id f25-v6sm16606266edd.87.2018.06.07.11.12.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Jun 2018 11:12:37 -0700 (PDT)
Date: Thu, 7 Jun 2018 20:12:34 +0200
From: Simon Horman <simon.horman@netronome.com>
To: Sean Young <sean@mess.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
        Matthias Reichl <hias@horus.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        netdev@vger.kernel.org,
        Devin Heitmueller <dheitmueller@kernellabs.com>,
        Y Song <ys114321@gmail.com>,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: Re: [PATCH] bpf: attach type BPF_LIRC_MODE2 should not depend on
 CONFIG_BPF_CGROUP
Message-ID: <20180607181233.oazgcezk2tgeiuqc@netronome.com>
References: <cover.1527419762.git.sean@mess.org>
 <9f2c54d4956f962f44fcda739a824397ddea132c.1527419762.git.sean@mess.org>
 <20180604174730.sctfoklq7klswebp@camel2.lan>
 <20180605101629.yffyp64o7adg6hu5@gofer.mess.org>
 <04cc36e7-4597-dc57-4ad7-71afcc17244a@iogearbox.net>
 <20180606210939.q3vviyc4b2h6gu3c@gofer.mess.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180606210939.q3vviyc4b2h6gu3c@gofer.mess.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2018 at 10:09:40PM +0100, Sean Young wrote:
> Compile bpf_prog_{attach,detach,query} even if CONFIG_BPF_CGROUP is not
> set.
> 
> Signed-off-by: Sean Young <sean@mess.org>

Hi Sean,

This patch seems to involve rather extensive refactoring, the details of
which are not explained, in order to make a change whose motivation is also
not explained. I for one would value a more extensive changelog if
not a series of patches which implement discrete changes.

Thanks!
