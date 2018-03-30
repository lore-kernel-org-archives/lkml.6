Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2746287-1522389977-2-18420814892600224056
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522389977; b=mF/a6awujW8wSoG+LJ5vWC8nbipvAKZsTPoWH5TWxtrovwfrz7
    66nqiA0qxSIk7/UTAYzArsGSkEXpRgQnMyHzLRFyrWF05u8WkYcSxEZ7umZHscug
    CcPIRtFMC7egXxP7MAr77vkDjqyqvRUOERPD9adEszfTL2W5fNxsGibgaEQnf9LJ
    5nxYsctFjXYlvDe2bvcdpIL+zLpG/DCeoTFT2jjRLB34XOtPmS4jH2BZ+3DLbeVR
    lnzThh/wKGl5PlALxDnumLtwS5skW3nRJQgQI85IMZU6LTGtXtaik5DxwKD+6dAo
    G44DeJKr/1ro3wYRfxEkeGbTY68buGGd5Reg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:date
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522389977; bh=lu6yZ
    LV3m9pBjoCz/tJ/7ZxiLvPAXoYSiQvEqg9K7Ys=; b=iToUTTenfKjmySGUqD6Y+
    gAcUX/PhpxWN4B2WCu7NX5eqWJ35PDcS/1Mrm34FnCSj1yRb7aznJ6NGLh6LI00/
    jCGaUqqq+d/9jR5EXRNwXmAnEsOPkzwdVnRZFEerAx+vIbxTZ5gZeoCXRtaHaby0
    KFxMfE9k1wrnfFxVlbsukMT3zIqeHlWvfhtrW1SRdRoye82S0kRqE/zDSFFRsJTV
    GUnrop92KerS0SDN3EUQxN78QnX1J8HLp3s9YMnKsuT4DrbfUYxSQomUxgAqtXR3
    3atSghB6P5uRRRc1xV/iqVo+SGLB+FkNyPuy1h2OeccNDM6giVoh5vCm5PA2GA5v
    Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=perches.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=perches.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=perches.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=perches.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfI16FMOBbqVbDGvwmFF8yu7XaRFolXmYzWZkQKqkbB0WttdQJwP7B/h8bnTqMcxRY42knxDC2GXAMtqJLQnsyIiKI9XMKiLfiJz1dnHoW3BDFs8pKUG7
    gT3a4yD56gWWwR/rrkaYyL/8Sx25iESkowgIcCamc8zg7OngxkZ5M65EKvINRH83oiwPmu77mFCwazE5P2LUr0wTBJFFpIbE4hxg4jj4uUBnqwQseaUmHf9x
    StT/9n0fAwEaC4iZVlAFTg==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=cUzyIW75ZKYjmxImxzQA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Remote-Spam-Summary: 2, 0, 0, , d41d8cd98f00b204, joe@perches.com, :::::::::::,
 RULES_HIT:41:355:379:541:599:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3870:3871:3872:3873:3874:4250:4321:5007:6691:9389:10004:10400:10848:11026:11232:11658:11914:12296:12740:12760:12895:13069:13095:13138:13231:13255:13311:13357:13439:14659:14721:21080:21433:21627:30012:30054:30079:30091,
 0,
 RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.14.0.100 64.201.201.201,
 CacheIP:none, Bayesian:0.5, 0.5, 0.5, Netcheck:none, DomainCache:0,
 MSF:not bulk, SPF:fn, MSBL:0, DNSBL:neutral, Custom_rules:0:0:0, LFtime:20,
 LUA_SUMMARY:none
X-HE-Tag: cave15_8c4daef027d11
X-Filterd-Recvd-Size: 1621
Message-ID: <1522389962.2210.38.camel@perches.com>
Subject: Re: [PATCH 1/9] staging: ks7010: Replace manual array copy with
 ether_addr_copy().
From: Joe Perches <joe@perches.com>
To: Quytelda Kahja <quytelda@tamalin.org>
Date: Thu, 29 Mar 2018 23:06:02 -0700
In-Reply-To: <CAFLvi20F6HhQqunU2Pde6e4fahFHEnRW2sR-c6V0L-fbsMJQhA@mail.gmail.com>
References: <20180329055152.13059-1-quytelda@tamalin.org>
 <1522303346.2210.19.camel@perches.com>
 <CAFLvi20F6HhQqunU2Pde6e4fahFHEnRW2sR-c6V0L-fbsMJQhA@mail.gmail.com>
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
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
Cc: devel@driverdev.osuosl.org, Greg KH <gregkh@linuxfoundation.org>,
 driverdev-devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
 wsa@the-dreams.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 2018-03-29 at 23:03 -0700, Quytelda Kahja wrote:
> If we just want to have the address field full of zeros during the
> driver probe, is there a reason we should zero it explicitly here?
> When the 'struct net_device' is first allocated using
> alloc_etherdev(), the dev_addr field is explicitly set to zeros (in
> the subfunction dev_addr_init() in net/core/dev_addr_lists.c), so it
> should be zeroed already at this point in the code.

You didn't describe the removal in your commit message
so it looked unintentional.

You should describe _why_ it's OK to remove it in that
commit message.

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
