Return-Path: <linux-next-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-1918895-1528140720-2-10442003243524772216
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-next-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528140720; b=eObaVzGO7t2A/TmxyPjJ4e5WmMIYZAMsJ2g+9xE9fy6cM3T6fy
    AlElvJz6wOSr7V5MwEhXDNnNU2Y36kMfjD8a4bLZzvOFETKN7uO4fv2DPa7jc4+S
    i9SklIsLDYFA4aC1R7IW25L5fUdPT17N0He4rLRwBUHqzyqoae9PHOFAU/W5yjRc
    s17sPbj74TG2N2t9JTas3R6WTj1ZiPoIcEde8vdDYmXD3/BgZC/9mWk/98o/om6v
    ia7ErATBh27FhgX6IjknXunSQBTOEIA+AnKEDwcPcT9mFfWV9yGqRp5DdGLId1o2
    10oRGuVvt6pkS4tNydTQonm4ZhhaTgvZr9xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1528140720;
    bh=iwfKAISZBG+aMXCcqQo/KTQzlHfvclkaB13qwEb5c/c=; b=hIXX5spOjnGW
    GWNXE6VO8nTcgRbcd/zX/+cJRHJ2blXl7f4SMZ2YAbzFe6r6sFEU1pw3RaHpfc49
    cdZ78KgW7aQC689t+EjKNPLG7fbItwZ/Y9xNcT8iO5zRS+2VBmyVaSay5+Fcrwzh
    ikVr91nlZxqzhTjgQ0dNFo4Ygo9mskBkASYkpA4kGJz6SuFPZen1/Vzw/icHwYwx
    5ezoe13h0CyXk3hByG0mpHOgXt1rw2yzMM1KX1EmqKu3WSYUuEd8xEJzIwJyCF7Z
    UGf8hGdWXoJHNwhP7Op4cnAg/chE/MNoLLWQdd8QLLdXgXdS7WDYElL1zHIbr80M
    1LjwXjI5cg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-next-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=goodmis.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-next-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=goodmis.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfB4XjiwKtmBBqt4oP01XExFk5tg5YmPiKAmtvGeS3ZGS0qihOISdkj1sKgTb4I4nSWbnMru7VjgkBkxcL16HnHwprZwtUpKAFl7Exm1OLJ5bYmUmBuFg
    JlWCQIYfN+WNoVgK8keIc4fCoSp67JQBA3Njr9l1hFBXe0AGLlJhjOQLnocmTwGtSiW9mJmm80jTdJ7pDI2p4+pVIxMzwzkM15FlB4FYeMNFZIjZdat57plJ
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=7mUfYlMuFuIA:10
    a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8 a=ehT0UVN0Hiigjcx0_lYA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751201AbeFDTb6 (ORCPT <rfc822;linux@kroah.com>);
        Mon, 4 Jun 2018 15:31:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:43168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751099AbeFDTb5 (ORCPT <rfc822;linux-next@vger.kernel.org>);
        Mon, 4 Jun 2018 15:31:57 -0400
Date: Mon, 4 Jun 2018 15:31:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Mike Snitzer <snitzer@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        dm-devel@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Jun 4 (md/dm-writecache.c)
Message-ID: <20180604153155.035a7856@gandalf.local.home>
In-Reply-To: <7b566935-a03d-ecab-be2a-10e25e4554f6@infradead.org>
References: <20180604215911.75399f6e@canb.auug.org.au>
        <0e3fa62d-727e-ccb8-53ae-a6aaa6c506e2@infradead.org>
        <20180604182259.GA5440@redhat.com>
        <7b566935-a03d-ecab-be2a-10e25e4554f6@infradead.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-next-owner@vger.kernel.org
X-Mailing-List: linux-next@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 4 Jun 2018 11:27:55 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> > AFAICT, this is the correct fix:
> > https://patchwork.kernel.org/patch/10438865/
> > 
> > Not seen any response to it (Steven and Ingo were emailed, Arnd and LKML
> > were cc'd).  
> 
> Yes, thanks.  That looks good.

I'm still digging through email. I've been traveling all last week.

-- Steve
