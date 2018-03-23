Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1133089-1521805388-2-5109706946717741592
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='hr', MailFrom='org'
X-Spam-charsets: cc='iso-8859-1', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521805387; b=olo1+yESKDtvh547l9cw7FIH5vCk2XBtik/pb1Ie+pipzmq
    +AQ1iWUtghn7JXuRAcg0HBK6/MKU7eOf0rteT5OT3oHJoeLjHtCx04MJitGavS77
    qo8lQkGkh5PWdvBpMhQVdl4V4RGMsoXb3OhwzWFZLkzKOJdCp9LgwNAhJXLJ6awv
    UzzggMQicYZJfMVnOqQlgzwiusd7VLO9fnlkoXTfoGoyn7PMus19tjWKe/QDnXEL
    HzWznr3amTXwM6GJpeoeGvHzDXq36C882Ny0Xyx7y93+jHg22qvpgmMwW7NA8DPR
    +N0xahFfZgX/3p1vPf64QQbMmfBahC+Nl8a1gPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:message-id:references
    :mime-version:in-reply-to:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521805387; bh=a
    WUKuS7tAu/flvXY7iY3M64Q+g3ibGzsO4wUd92RqPg=; b=aoB9ymfZ5EGbSWXOl
    eHoYsJNUyxqe9ixwT+3Pzahpe+XBuuFZFoCoy6VAbzP4J1C8F1iMYU1VbGkPnPiz
    tBkaI35mIpLiYZv+g/bSCiQRX8nxXm55KaO59o+Ox4YX7Qf5Tz8KWxw1dCdgcPGS
    iX/ot5hLJV5jpxeHLBK3kN4CkDTSKhIFlK+6eQ2yu7HcmdftcBl4pVhgJOA/sSXR
    xQYvx0/J6ntPm9TRrKF8p5V5nJmhGhMf6tNR0dDrMi1rb0Ncwdf+91aveeU2Lo3H
    oUdrZUPxdp8u9t0mgPU6Cm1uTm4MwMIwyEuq7LzBvJBEB6C/OHM/3r41xSx3cgjk
    SM0hg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=carnet.hr;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=carnet.hr header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=carnet.hr;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=carnet.hr header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Fri, 23 Mar 2018 12:42:54 +0100
From: Valentin Vidic <Valentin.Vidic@CARNet.hr>
To: Marcus Wolf <marcus.wolf@smarthome-wolf.de>
Message-ID: <20180323114254.GL31333@gavran.carpriv.carnet.hr>
References: <20180323094725.4904-1-Valentin.Vidic@CARNet.hr>
 <d263c605-f652-fe24-2034-c699f2d27693@smarthome-wolf.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d263c605-f652-fe24-2034-c699f2d27693@smarthome-wolf.de>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-SA-Exim-Connect-IP: 2001:b68:ff:12::131
Subject: Re: [PATCH] staging: pi433: add descriptions for mutex locks
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
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
Cc: devel@driverdev.osuosl.org, Derek Robson <robsonde@gmail.com>,
 Michael Panzlaff <michael.panzlaff@fau.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Luca =?iso-8859-1?Q?S=F6the?= <luca@acul.me>, linux-kernel@vger.kernel.org,
 Marcin Ciupak <marcin.s.ciupak@gmail.com>,
 Marcus Wolf <linux@Wolf-Entwicklungen.de>,
 Simon =?iso-8859-1?Q?Sandstr=F6m?= <simon@nikanor.nu>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 23, 2018 at 11:22:39AM +0100, Marcus Wolf wrote:
> could you please decribe in short words, why you think, that hte lock
> isn't obsolete?
> 
> I wasn't sure, but close to remove the lock. That's why I putted the
> comment.

Sure, if pi433_tx_thread runs on one CPU it might be possible
to call pi433_write concurrently on another CPU and they would
both modify tx_fifo.  But maybe there is some other protection
in place that would prevent this?

-- 
Valentin
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
