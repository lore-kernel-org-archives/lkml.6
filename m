Return-Path: <SRS0=7usb=GJ=gmail.com=htejun@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3339826-1521479425-3-15847969317572551828
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='198.145.29.99', Host='mail.kernel.org', Country='US', FromHeader='org',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: SRS0=7usb=GJ=gmail.com=htejun@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521479424; b=pDAAf3FExkFzSxAv4LWWJG2ZgKx9PYzFB1m050mu554xXcp
    pd211Hrk6glaMonyTRrXR+y57sZUqxkJygjNGhKNhIG319Pfr5zW8GISjsWRMtjC
    jFfMJq1xKwzaPaes1sPFOswvIP9PAvKiCvB/pcBliKPsdeFc6nUWzG+3QH2KJ1Hv
    H60GLsBy1zwJ5VbxvjxvfDirFOUP9A00TpKlqjh7nFUjXqi/Ish3tUJpso8fcK9R
    6arpdk5em97OP5ZYf/sTmVdCIWkWcwZTQikoex3PI/B74wvIqKKsMomb/V6+xzZt
    ASvQ+vu9n94M0zJqYmuOu/14ZM5yt+/Gxs4KmWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=sender:date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to; s=arctest; t=
    1521479424; bh=Hdl9nWV618G2h89ZQQFpHg21ZsLyXfLfYyeQ2Wjkzbo=; b=S
    p2gQ7LxwPzjlnoFCvMHKqYNgBAKmzktxeRBGHAGafh671dokX77gib1+hYMiup5r
    jq36MTZOhghesX9wBY8UJdgbydJoRlqiPx4aVSKvS1G10UmhEDOBcuKQBEFCxsek
    5UCSmX6hS/GbZ0tddeeGwiDzjM8ztPYrnyck0fFye+giz0iTkmrXhaJiWxBfXI6g
    7o8+CcyUMXzgak2JKBtwwl5ytI2qRWlwil59q3LjS8bSHSQsvkjIe9yBGXlxYpnb
    QgG4QepbXTTbGkF/t1QiE4q9jmPUBGQuWtW5+24kA5LlJOQA+IwW2CnmkQDudPXn
    d0L7jsORAKaVf2Td+/ZIA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=SmVmYi+j x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom="SRS0=7usb=GJ=gmail.com=htejun@kernel.org" smtp.helo=mail.kernel.org;
    x-aligned-from=domain_pass (Domain match);
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeljeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucenucfjughrpehsfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepvfgvjhhunhcujfgvohcuoehtjheskhgvrhhnvghlrdhorhhgqeenucfkphepudelkedrudeghedrvdelrdelledpvdeivddtmedutdgumegttdeludemvddttdemmedvmeejvdgsgeenucfrrghrrghmpehinhgvthepudelkedrudeghedrvdelrdelledphhgvlhhopehmrghilhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoefutffutdepjehushgspefilfepghhmrghilhdrtghomhephhhtvghjuhhnsehkvghrnhgvlhdrohhrghequcfukfgkgfepfeelkeefnecuvehluhhsthgvrhfuihiivgeptd;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=QCJIIQiN;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=SmVmYi+j x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom="SRS0=7usb=GJ=gmail.com=htejun@kernel.org" smtp.helo=mail.kernel.org;
    x-aligned-from=domain_pass (Domain match);
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeljeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucenucfjughrpehsfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepvfgvjhhunhcujfgvohcuoehtjheskhgvrhhnvghlrdhorhhgqeenucfkphepudelkedrudeghedrvdelrdelledpvdeivddtmedutdgumegttdeludemvddttdemmedvmeejvdgsgeenucfrrghrrghmpehinhgvthepudelkedrudeghedrvdelrdelledphhgvlhhopehmrghilhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoefutffutdepjehushgspefilfepghhmrghilhdrtghomhephhhtvghjuhhnsehkvghrnhgvlhdrohhrghequcfukfgkgfepfeelkeefnecuvehluhhsthgvrhfuihiivgeptd;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=QCJIIQiN;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: security@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8936621736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=htejun@gmail.com
X-Google-Smtp-Source: AG47ELsiG/KqXZTB53IxdzUGVGGjgzWqA5rimlOs91FtEp8auemIyGPgCHGF1f4aJ4vuXCgVU9mWjg==
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 19 Mar 2018 10:10:19 -0700
From: Tejun Heo <tj@kernel.org>
To: torvalds@linux-foundation.org, jannh@google.com,
	paulmck@linux.vnet.ibm.com, bcrl@kvack.org, viro@zeniv.linux.org.uk,
	kent.overstreet@gmail.com
Cc: security@kernel.org, linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 5/8] percpu_ref: Update doc to dissuade users from
 depending on internal RCU grace periods
Message-ID: <20180319171019.GD519464@devbig577.frc2.facebook.com>
References: <20180314194205.1651587-1-tj@kernel.org>
 <20180314194515.1661824-1-tj@kernel.org>
 <20180314194515.1661824-5-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314194515.1661824-5-tj@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 12:45:12PM -0700, Tejun Heo wrote:
> This patch makes it clear that the grace periods are percpu_ref's
> internal implementation detail and can't be depended upon by the
> users.

Applied to percpu/for-4.16-fixes.

Thanks.

-- 
tejun
