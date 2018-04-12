Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1450961-1523553323-2-11905001461137495056
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='hr', MailFrom='org'
X-Spam-charsets: cc='iso-8859-1', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523553322; b=UnK+KJiQaJGQjBVs3XNG0UoBQeTF2o7wYF2gz1KpWllOAk+Edy
    OCKloon3DcSAy1ZrzO2/rElFVl8kqtHlx7KIUPoL2W1DqPSQXdxU8w34Y2WKnSS8
    rB52aBhV+Qh0ClokXvLu08DPNmvvVKE3iUJ3L5BkCLP6qe8+uysTgvmcyb6HjXl6
    8mNq0pqiBY0iw4mT8fOUBUK/2YWN4E5WAiDenjaaaU/hu/QwtTW1s34rAbTW7VwU
    ZVvNKUlg/E8xtF3yO/5n059pCUBtC7kcjOExIXDglHnxjUYJUgfz/mKKQfcZWMtF
    VTKsnqTrih4C4zotABfoZ7IsUWenV5blVUqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:message-id:references
    :mime-version:in-reply-to:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523553322; bh=I7Mbh
    BJdAt4MRyJP01UsCVwKekf8CBYWyTXe7Uk4CM4=; b=ekPTWPtAxp/9yqAV9/5P4
    7dIelyYjstoVZgcgiEabsJQri3OuKUgQsLkAiSaXVLvGHbUY/xJyvsaOAGaJMCmd
    zKtLOpko+e/iQWwY5YZt3EKjsjygjpHTLD0U1I3615ZrX+dnsxtQLsVOO3EmscOs
    yEGU09ejHv4mq7wy3kmbXu8UgvmTTBfpHEPXMvJqrT9CptArtduC21rpBHCbMTz6
    xMLal102kawZYsjb1pK9uvbXHlOsaMVL+Vl7bERV78q0SDa7dL0kERYj45lRvaIP
    +75q7u06fGRHIMo62Gs6JnSr/x/TID48L3YQ6fLcTCuW28iqxjGCYTYWtFCPwlC2
    g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=carnet.hr;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=carnet.hr header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=carnet.hr;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=carnet.hr header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKBzy6tOpItAZ3+CeEjGyL5J5FsZ+t5PyTapO5ncJ0kjjaEEFeMFlAGIR3DIr4IfejLBsJEtZ9xZhF7IYYk1DkZj7jsuTGNpDa43QrtvWrWBpOG4kLi8
    /Q7y2fZKhOyNlbJtRIzR87MGObiQzuwnkcO6p96JGtByFYYvwQZ1XGtQqPCzMBZDhSbnUQfnRa2fIAxC+G8hwwzsSHw6XhdI/m/7a94DhTq0ADAKUz2I3Amg
    hgjVhFTdOHXRXrSBB+6Avg==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=ifoZFUwOAAAA:8 a=DDOyTI_5AAAA:8
    a=BOWCWlpv3zYUauG4Eg4A:9 a=CjuIK1q_8ugA:10 a=yfv2_UWFUko4AKzirQaJ:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Thu, 12 Apr 2018 19:15:04 +0200
From: Valentin Vidic <Valentin.Vidic@CARNet.hr>
To: Marcus Wolf <marcus.wolf@smarthome-wolf.de>
Message-ID: <20180412171504.GU3257@gavran.carpriv.carnet.hr>
References: <d263c605-f652-fe24-2034-c699f2d27693@smarthome-wolf.de>
 <20180323114254.GL31333@gavran.carpriv.carnet.hr>
 <9442615c-5606-328a-f8cc-ad389af55ee3@smarthome-wolf.de>
 <20180323180027.GM31333@gavran.carpriv.carnet.hr>
 <20180323221821.GP31333@gavran.carpriv.carnet.hr>
 <8544b858-673f-0f59-0d8b-0474036068ce@smarthome-wolf.de>
 <20180325130944.GU31333@gavran.carpriv.carnet.hr>
 <8eba67bc-7480-f07e-9022-1aa19a4881f5@smarthome-wolf.de>
 <20180325142414.GW31333@gavran.carpriv.carnet.hr>
 <849553ae-5f62-0a06-f545-4d0fbaa513c3@smarthome-wolf.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <849553ae-5f62-0a06-f545-4d0fbaa513c3@smarthome-wolf.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-SA-Exim-Connect-IP: 161.53.12.131
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

On Sun, Apr 08, 2018 at 04:15:30PM +0200, Marcus Wolf wrote:
> The hardware of Pi433 is working with every Raspberry Pi (on zero, you
> need to solder the GPIO-pins) and with several other fruits like banana
> pi. The only thing is, that you need different versions of the driver,
> according to the processor, mounted on your fruit.
> 
> If you'd like to test more then ther is no hang up or crash, you will
> need a second party. You could use a 433MHz socket for testing TX or a
> 433 thermometer for testing RX. An example code for communication with a
> socket is available on the Pi433 productpage (www.pi433.de). The sample
> for the thermometer isn't published yet (as always lack of time).
> 
> If you want to test more deeply (using different features of the Rf69
> chip or even do some long time testing, you have more options, if you
> use to Pis with Pi433.
> 
> Just let me know, what you'd like to do and what equipment, you need.

At the moment I have Rpi2 but not any other 433MHz equipment, so I
could only do some basic testing unfortunately.  In case I get the
new Rpi3 some time soon I would be able to do something better.

-- 
Valentin
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
