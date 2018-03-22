Return-Path: <davem@davemloft.net>
X-Google-Smtp-Source: AG47ELuAjlId0XdZsldXuW00HbAqYHMt8lmKLT9dTTW1OL3U3sW+xgrH9hPT8YdBFzvvnm4ac82b
ARC-Seal: i=1; a=rsa-sha256; t=1521731939; cv=none;
        d=google.com; s=arc-20160816;
        b=WZFhZK3Arruf+S31QmwRjDV+2sxOpVBl3MJndWPnQu6BhhJs+tac/x3pBAwSNW6kwN
         GM0YNNlGKfA6JdAU7aF4WVUYwd0IRaTGlqr2Qw3m3aeUWC4xcC1q0fI6qGXtRWHRd/UQ
         RsLzvS2EvSzBXkn2rHFMbphZQ9o0+4BMjG5ZA5gGHVObkiIGEmCP3ZP0uqocp9shQUKi
         LvoWvvezhGqhUgLjtNC0ZtIaZigBD4VYK36cJSBFEjDHKOJKBeiHevYkQxGdw0NueeJp
         jXSLk5b9aytR5fhHLPN0w1bJA6coj/5Bpntm4EckZFbB4lY5lo+2rsj1PTQiccVkzEye
         NaSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:arc-authentication-results;
        bh=qKDXadIJe2AJhSeSpFb+WrUPiR9DblgF47x2Fqwt9bY=;
        b=IAhxc8Nz3s2eCsiMQ1NuuAIV4EUEX7X3FG5I7MReKYZGO6OzKMOcCUKA5xJjDjPx34
         KNY2gdtCAn1BAGKULqlweYozy4mJ+QFTTCbsmSUESnGkTL1qtbgrMKIZSkJ41ISY8+Kv
         3YuEkxBbJfvqd4xPnhY+RBe6n66QLYBDQ4lrondijCfzTOfF+Go42dO/6ERmke6xOoEb
         bLbZ7nr8jGph9n4mkUaK+gAesreO4Ww4LbABVROns4ufrZ4b4Pd3+dQJpIhcAaFiHhxR
         dXoJyFkWREoFfbML3hXC5Tw5h3OjKdNI8rnlc/6ByKAjr4i/Ap6adktSMDZMPNplFGiN
         11Hg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 184.105.139.130 is neither permitted nor denied by best guess record for domain of davem@davemloft.net) smtp.mailfrom=davem@davemloft.net
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 184.105.139.130 is neither permitted nor denied by best guess record for domain of davem@davemloft.net) smtp.mailfrom=davem@davemloft.net
Date: Thu, 22 Mar 2018 11:18:57 -0400 (EDT)
Message-Id: <20180322.111857.1028150110177038050.davem@davemloft.net>
To: christian.brauner@ubuntu.com
Cc: ebiederm@xmission.com, gregkh@linuxfoundation.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, serge@hallyn.com,
 avagin@virtuozzo.com, ktkhai@virtuozzo.com
Subject: Re: [PATCH net-next 2/2 v4] netns: send uevent messages
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180319121731.14449-2-christian.brauner@ubuntu.com>
References: <20180319121731.14449-1-christian.brauner@ubuntu.com>
	<20180319121731.14449-2-christian.brauner@ubuntu.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595368389297520360?=
X-GMAIL-MSGID: =?utf-8?q?1595651589610251747?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Mon, 19 Mar 2018 13:17:31 +0100

> This patch adds a receive method to NETLINK_KOBJECT_UEVENT netlink sockets
> to allow sending uevent messages into the network namespace the socket
> belongs to.
> 
> Currently non-initial network namespaces are already isolated and don't
> receive uevents. There are a number of cases where it is beneficial for a
> sufficiently privileged userspace process to send a uevent into a network
> namespace.
> 
> One such use case would be debugging and fuzzing of a piece of software
> which listens and reacts to uevents. By running a copy of that software
> inside a network namespace, specific uevents could then be presented to it.
> More concretely, this would allow for easy testing of udevd/ueventd.
> 
> This will also allow some piece of software to run components inside a
> separate network namespace and then effectively filter what that software
> can receive. Some examples of software that do directly listen to uevents
> and that we have in the past attempted to run inside a network namespace
> are rbd (CEPH client) or the X server.
 ...
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

Applied.
