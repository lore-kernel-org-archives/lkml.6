Return-Path: <kernelnewbies-bounces@kernelnewbies.org>
X-Cyrus-Session-Id: sloti22d1t05-3530641-1519152602-2-15320726546681729933
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001,
  RCVD_IN_DNSWL_NONE -0.0001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='96.67.55.147', Host='shelob.surriel.com', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: kernelnewbies-bounces@kernelnewbies.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519152601; b=Xswh3yvHWkwDTspHWUY3wG3stggJWcr8x2SiGqEP/RG0wqP
    ao0WTT199Q+/MsRAJ/hjLuECIS75rHRRW8AiNBa6F7OyQaQYdKvS2yItrMD1hvZV
    9DJTAy60CIUHiDo436CbelOE+MndqrxLC/Sga0+DxUKe48LfDWJD2/hePDgzOsdo
    M4Zdx5I12zAuZ+VgfDZME9qE5/JQ239kgTTGmyTTQ6iSMsSUdUhu4sqtz/uuLnV3
    LI3SrL7bxey/SYdIh8RmgxowLFcT5ozZHFNSaigGo+T5zpLQ55wQtHfBzeTRvauU
    +GYZErmJTfU6sbVLLRZibrt1CPL4Rikp+JlTzNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:cc:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding; s=arctest; t=1519152601; bh=bG9sHf24
    Dp7N8Jync4YHRbEybQdfLLlcNYZQ4lp0ObQ=; b=P5O3HyXr/epfJkt/iDM417ja
    UFhyMhN+3JARuXdidK0PuP8vCwl4rz4VyNOeTmWdjGKHRfnRh4dyTJInBSOL7qsy
    AKpwe2XrKjanh3KUtq/N4r41aAXDw3K5mzO1BsuTIGZp202dbLhX6w8iYUySU+ZF
    XMOYeeBjAUFUzXoQeQb+FbQLBDX7ghtnpAK6TBYkkq6sxZL6BJiiCa9xAmi6LQ9+
    Nx5/Jg47wspw4egrrBoBDOss6/Jw42AwjB+VlysYIx0oc+pKzIjo0uYBpR2pQKJs
    tbBvuwTWsC7tXE3iUzHDp1vZ8JSN8mVooM79V9WSvc6K7NX3ROtz6RDGptLFDg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rjwysocki.net;
    iprev=pass policy.iprev=96.67.55.147 (shelob.surriel.com);
    spf=permerror smtp.mailfrom=kernelnewbies-bounces@kernelnewbies.org smtp.helo=shelob.surriel.com;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=shelob.surriel.com x-ptr-lookup=shelob.surriel.com;
    x-return-mx=pass smtp.domain=kernelnewbies.org smtp.result=pass smtp_is_org_domain=yes header.domain=rjwysocki.net header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rjwysocki.net;
    iprev=pass policy.iprev=96.67.55.147 (shelob.surriel.com);
    spf=permerror smtp.mailfrom=kernelnewbies-bounces@kernelnewbies.org smtp.helo=shelob.surriel.com;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=shelob.surriel.com x-ptr-lookup=shelob.surriel.com;
    x-return-mx=pass smtp.domain=kernelnewbies.org smtp.result=pass smtp_is_org_domain=yes header.domain=rjwysocki.net header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Ivid Suvarna <ivid.suvarna@gmail.com>
Subject: Re: Timekeeping warning during resume from suspend to disk
Date: Tue, 20 Feb 2018 16:22:10 +0100
Message-ID: <10932445.pQZk5yFdez@aspire.rjw.lan>
In-Reply-To: <CABXF_AD74A8SmXGA5T9ODbC4JnDuxQN9n8N_9RZrm8a7CtjXQQ@mail.gmail.com>
References: <CABXF_AAQVJ7eMt4gFhiEcgZTD7Y4R66-9ELZ1OJ2gAmKPeLMAw@mail.gmail.com>
 <20180220075425.GA13048@kroah.com>
 <CABXF_AD74A8SmXGA5T9ODbC4JnDuxQN9n8N_9RZrm8a7CtjXQQ@mail.gmail.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 20 Feb 2018 13:49:49 -0500
Cc: Greg KH <gregkh@linuxfoundation.org>, Linux-pm@vger.kernel.org,
 Kernel development list <linux-kernel@vger.kernel.org>,
 kernelnewbies@kernelnewbies.org
X-BeenThere: kernelnewbies@kernelnewbies.org
X-Mailman-Version: 2.1.15
List-Unsubscribe: <https://lists.kernelnewbies.org/mailman/options/kernelnewbies>,
 <mailto:kernelnewbies-request@kernelnewbies.org?subject=unsubscribe>
List-Archive: <http://lists.kernelnewbies.org/pipermail/kernelnewbies/>
List-Post: <mailto:kernelnewbies@kernelnewbies.org>
List-Help: <mailto:kernelnewbies-request@kernelnewbies.org?subject=help>
List-Subscribe: <https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies>,
 <mailto:kernelnewbies-request@kernelnewbies.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kernelnewbies-bounces@kernelnewbies.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tuesday, February 20, 2018 2:49:24 PM CET Ivid Suvarna wrote:
> Hi Greg,
> 
> > 4.1.15 is a kernel that is very old and obsolete (released almost 3
> > years ago, and tens of thousands of changes old.)  Please try something
> > newer and more modern like 4.15.  If the issue is still there, the
> > community will be glad to help you out.
> >
> > If you are stuck at that old kernel version for some odd reason, please
> > get support from the company that is forcing you to use it.
> 
> Thank u for your kind suggestions.
> I just tested with 4.14 kernel on same board and am still facing the same issue.
> Is there anything I can look into for debugging this issue?

Can you add a bit more context from your log, please?


_______________________________________________
Kernelnewbies mailing list
Kernelnewbies@kernelnewbies.org
https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies
