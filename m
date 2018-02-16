Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-497716-1518798240-2-436421275104899625
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518798239; b=k8CXpAZnpwAn0hCe/3NIhNXkT8+fxNPrf4kcV0l4H9QKjQk
    bKYLx16C/BbwA2l1OaUwPyTOcXlbaAmfQ0vkMASHlO+rIY37JqBLojqqTGvSVKuy
    oQexgPNd6Hrc4ALIKqUG+Q6O4+PLdHhkDKAoWtwDTuzow5fy6/ZnjGiv4DKSEm/i
    2QSI2Tk7zW8FCjudNkR2RtBEi69+dEImOalPJGK0kT7eKOKyfmsk0s/HNEYkY3Lf
    IYjrg/FoXGX4Ys3wvXWqxs1igxpncLAJop6xO8L5c6kgKIk4/yw67pJA71an9BYF
    wUNzw68GdjMZfWLsk6HhLympb2ph7oLhe1ED9wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518798239; bh=4
    lJhiVg6menFQf+/lm/cEXVgQ2y9vPCnXNYWhcuVEK4=; b=skD7MSJTXozz4WQjr
    a1G2OunJEmTzy42S38nlNQAhSdA7m9fe7AI1UwsdxXYHYEI1EoPV2T8mnTQUUdla
    v7atzYIzD/UCiE7jkpuvbLKjDrNqRLEGmPCnzPhQLeQXWOPGjkmGwbFG8ibZyXA9
    sNaykbXIp2M9qzD7hlvEkzuHQW/FDXxxByDro2OrB/X8xJaR8NjBz3wD2j4qbe7V
    PDn2y/qC7TBZxQoX76HGUywAVYwR4CrfnF+MN2XKBgRekDevjYZBEmgOxlGsngv2
    Um3lOy1q+AoR4rxgdX/EKx6HjNdc21A4PT5tiyLMrlynT5dv8rmioESdkUF5o1Zi
    iEwUQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Fri, 16 Feb 2018 17:23:53 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Liam Mark <lmark@codeaurora.org>
Subject: Re: [PATCH] staging: android: ion: Initialize dma_address of new sg
 list
Message-ID: <20180216162353.GA13019@kroah.com>
References: <alpine.DEB.2.02.1802092203150.2846@lmark-linux.qualcomm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1802092203150.2846@lmark-linux.qualcomm.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, linaro-mm-sig@lists.linaro.org,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 09, 2018 at 10:16:56PM -0800, Liam Mark wrote:
> Fix the dup_sg_table function to initialize the dma_address of the new
> sg list entries instead of the source dma_address entries.
> 
> Fixes: 17fd283f3870 ("staging: android: ion: Duplicate sg_table")

So this should be sent to the stable trees as well, right?

Please add that when you resend...

thanks,

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
