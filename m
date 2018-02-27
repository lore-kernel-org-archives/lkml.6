Return-Path: <bigeasy@linutronix.de>
X-Google-Smtp-Source: AG47ELvwAKFYicOTGcQkcXOQmC6nXrcQBkgS9NCmSWSm4BJK0qZi5Z3z4197XzOJnNMVTOPFnG5j
ARC-Seal: i=1; a=rsa-sha256; t=1519752801; cv=none;
        d=google.com; s=arc-20160816;
        b=kUREZ+NkrCRWnoDSEE/GVcW8vpaHbJx0e/quAZkhnofy03TCDOv+Slib+kxT6NM2gm
         LkXStQAVALmO4nPuT3jdY+6UuyNqLfNksCrHtZkotDGgWN8KVvBuvNLg9EJu4jtjWEBf
         qIiJaDlQn/Ge/J39/H0c4RsWpIOXpPr6uXjedIxV0FB9T1oFG5vZ0IvTUBQ/fGUKxrpc
         ZsLcOdFHiboZXTfgPuk/hrrcxNQAELLO27ryLFWHzrwQ4YQdZsM29es6pl/gtS4lJ4ow
         4L++JuhKH9JCoXpQg+K/Iot1c0Zg5OvaYZfs9dc9/jjsBod/WXv43i6Vjy49j0vHOQm4
         raKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=Eb/tYaUYfrPtWcmZSM2C9Zl/fL6KWpIJd/g4N8jXETE=;
        b=pEfzauhSmYN3nbUjweHfWk/euNl9fodK+mZP8e31FaH0/jiIV1ju+daoQrspJDwN1V
         S6KrzyBq4WhR0CI2Br5ccC9xnroxSQTrdQkQq5p2aAREVJCJAYeH/51siK6G5rBJH57+
         bH+OhuNZQ9nQe7fuuz/oXMFdXK0byfKXPZR9qIG8Dn57ORrCNpUx8fOihj7wO0EzQ1DV
         FGtQFi3FayA9JjgazhHPjN33y3aB9bbD0U+eiIPEXWkUW8xJw2cEtu3TI/ke2XuMkAwD
         JGlubQskrkuHcuRrjbppaG3yWyTCU63EL3ptnz2BpzyqOtvKnsMQ3P5GmW3D79He8A64
         lVGg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of bigeasy@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=bigeasy@linutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of bigeasy@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=bigeasy@linutronix.de
Date: Tue, 27 Feb 2018 18:33:14 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Gary R Hook <gary.hook@amd.com>
Cc: "Hook, Gary" <ghook@amd.com>, linux-crypto@vger.kernel.org,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: Can a driver->probe be called for two devices at the same time (WAS:
 Re: [PATCH] crypto/ccp: don't disable interrupts while setting up debugfs)
Message-ID: <20180227173314.uko5xpf4od2fn74g@linutronix.de>
References: <20180223223307.18882-1-bigeasy@linutronix.de>
 <3f0e1a62-a7ea-6d0c-d305-67080803aefd@amd.com>
 <20180226083508.th2m3xssp36lx3zh@linutronix.de>
 <372b353d-017d-a72c-b750-9417f6265874@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <372b353d-017d-a72c-b750-9417f6265874@amd.com>
User-Agent: NeoMutt/20171215
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593576313003977918?=
X-GMAIL-MSGID: =?utf-8?q?1593576313003977918?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-02-27 11:08:56 [-0600], Gary R Hook wrote:
> That issue remains unclear to me: Are probes of PCI devices guaranteed to be
> serialized? Observations on my CCPs says that they occur in order, but I
> don't know for certain that serialization is guaranteed.
> 
> Is there a definitive statement on this somewhere that I just don't know
> about?

So the question if a driver can probe two devices simultaneously. I'm
not sure. We have PROBE_PREFER_ASYNCHRONOUS which defers the probe to
worker. However I have no idea if two of those worker can run at the
same time.

> I think a mutex would be just fine; I got this wrong, clearly. Let me work
> up a patch using a mutex.

I've sent one. Why not just ack it and be done with it?

> Gary

Sebastian
