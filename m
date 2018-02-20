Return-Path: <kernelnewbies-bounces@kernelnewbies.org>
X-Cyrus-Session-Id: sloti22d1t05-2326222-1519113278-2-9748295776704645456
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001,
  RCVD_IN_DNSWL_NONE -0.0001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='96.67.55.147', Host='shelob.surriel.com', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: kernelnewbies-bounces@kernelnewbies.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519113278; b=ZxJdl0+xBn8rCyP/vhjL2Fhjna6Se9BbRiglAu0vBKvsoy9
    gyo84N7ZGqmqJrn51aUcOf0TCZ0ETa+ozubn9JekpFWNUBx0bEooWAjl1P0GpYwK
    LwnEhrf1+CXyyb/7Rz1tRWLdIVZWEAv1CA5T40xi0T7u00tEYkml0fc46qLDXIQm
    VVN9dQqn20tBGYDE93Ic0Jak002FM5AOMPBI2R/Jc/t2Rka0iuhgUBCz8LRqv29A
    hPeo8YABaMPPqLJviVEaY4OXRBHiJIZt2j9mZrkGFPckM+hviIZTa1kw8fIUmI3e
    0zQzBwV19ZyGgCeMBvbuG4ATZcJ4s1PpPnROg8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:cc:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding; s=arctest; t=1519113278; bh=2Z6hb3L8
    hwQnRp1FsNAKvSm/+Mwne1Y94BwqEUOTHc4=; b=Nj9sM0RuxvimWxziJNiMaT39
    58FXpSXfmCqJgRF+fQsqfZChew2P+sWw8tBZHFta7isqQkSWyMepHMT4+sdj7Rwn
    /gewTZmKNpms941OrweSplKeK1E2KjYZpPW6lNAb671kjEWqJ6HNO7bwQSh9B89r
    BznsCVCMSYNFKADLLdvPs5JCCw4qeCfYtPxU/7sGWSZY9aMdZgGMWGPSjxPpse7n
    9PRZPyWPu25zllEX1PmXXrx8xzRQVVCqu593hi6s+aUi30O3DJZwkBMXIZvc2T8X
    tREgFby1/0apPclRpYtr3JMcnkmC3lCyOTcTsNhf08yCM0q9fjEtUX+R6+G9eQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=96.67.55.147 (shelob.surriel.com);
    spf=permerror smtp.mailfrom=kernelnewbies-bounces@kernelnewbies.org smtp.helo=shelob.surriel.com;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=shelob.surriel.com x-ptr-lookup=shelob.surriel.com;
    x-return-mx=pass smtp.domain=kernelnewbies.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=96.67.55.147 (shelob.surriel.com);
    spf=permerror smtp.mailfrom=kernelnewbies-bounces@kernelnewbies.org smtp.helo=shelob.surriel.com;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=shelob.surriel.com x-ptr-lookup=shelob.surriel.com;
    x-return-mx=pass smtp.domain=kernelnewbies.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Date: Tue, 20 Feb 2018 08:54:25 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ivid Suvarna <ivid.suvarna@gmail.com>
Subject: Re: Timekeeping warning during resume from suspend to disk
Message-ID: <20180220075425.GA13048@kroah.com>
References: <CABXF_AAQVJ7eMt4gFhiEcgZTD7Y4R66-9ELZ1OJ2gAmKPeLMAw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CABXF_AAQVJ7eMt4gFhiEcgZTD7Y4R66-9ELZ1OJ2gAmKPeLMAw@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Cc: Linux-pm@vger.kernel.org,
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

On Tue, Feb 20, 2018 at 12:53:26PM +0530, Ivid Suvarna wrote:
> Hi All,
> 
> Facing below warning backtrace during resume from suspend to disk. I
> am using 4.1.15 freescale kernel.

4.1.15 is a kernel that is very old and obsolete (released almost 3
years ago, and tens of thousands of changes old.)  Please try something
newer and more modern like 4.15.  If the issue is still there, the
community will be glad to help you out.

If you are stuck at that old kernel version for some odd reason, please
get support from the company that is forcing you to use it.

good luck!

greg k-h

_______________________________________________
Kernelnewbies mailing list
Kernelnewbies@kernelnewbies.org
https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies
