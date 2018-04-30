Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1748446-1525110560-2-5737901870480869380
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='net', MailFrom='org', XOriginatingCountry='FR'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525110559; b=aFDEUOIFB4lTw71cYahwQ1BOW76DzsB3B+e0II1rSnyMGm1fQB
    7h7CE4hjnG/QKlmSCMx0gIDp30UxlNe2IRiZvb6Ld/WBvRN5CYWzsN9+zW8fY97x
    XCjK4nAweFcB0WMQGvx4n/FT5m0zi5UEUF8iOfJSmZJ9zWDOCgyV8PoSP4HTQnXi
    b9kcYZJn8R2mlouDwyhBfNz/f+tsLXw9H4sGzj1wG/vCqPm50um0fm4tElN3am7d
    rb8bSKUP4GZRcXBn+GUyodIBGYcZvCfHnfBzm+LTrBaC//o3cWJzCBvATBpgg2r5
    lK6zscYj6rUfg7Z56gH/D1G++JaCYF74I/aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:date
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525110559; bh=DUxKp
    gPDKM9tHs4vog5LEQaKfJNfI+s0Oa8klhFsjIo=; b=H/zEMhi7AZOD5w8GDsy2l
    NjSMk12BASjANmEtNxDH3ULv8VPq3UO5BzY1ZKPB+I8X/k8hctmiX8TW9bJg7yrj
    FPtFza4+88XagDndHQ23Wjmz7ALdWh6qvglWDpXbg3QSbAYzl8j9kjEuRO47zaRv
    0OThsCJoEekh01iQAw3Wc5d2jxanlkt7GqMOo9b8mqJla/qYssy8+6bZ2YpW+mnf
    B/WdyqAupMc6Dr4l0NjRVzYl4ef8aRzWS3eO8xHeWgZZpeo6/lGo6L2s+ejMcqaM
    X5Zb3hdqOyDf+afHnks7wOch35nHDYd2O8soDjWLJOgKDnwAoSlR8qDMzVxQnn5N
    A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hadess.net;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=hadess.net header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hadess.net;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=hadess.net header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNyX3sn25cpQMzxNOlgYs1BGFx+u7FBdPe+CeQ2Rpu5sE8FACZVnjhF/daGmoIpVZnYgW6L5EZXeKf9z+omUHqqD0VPj3vTcRi9kAP3TXs/VmmLwq8D7
    AL0o7ftIqdugRmCNl0Pwj0cw49U9tDiR1JybULf92WEoeo5q4wtvj5TEltYPAfV++ktGNd947/X/Q7vTxElQnyPWzFz59bheutmikHWK5T4l9zB/3kZD6eZG
    dt/gUKJcWczvXx+L1EX6Mg==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=nef-8XxXxq8A:10 a=kj9zAlcOel0A:10
    a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8
    a=DzOXeqrlEnruMLf-oEgA:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Originating-IP: 83.155.44.161
Message-ID: <4e727467119e92364a9be63af80e7d671de984d0.camel@hadess.net>
Subject: Re: [PATCH][staging-next] staging: rtl8723bs: spelling mistake:
 "dismatch" -> "mismatch"
From: Bastien Nocera <hadess@hadess.net>
To: Colin King <colin.king@canonical.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Justin Vreeland <justin@jvreeland.com>,
 devel@driverdev.osuosl.org
Date: Mon, 30 Apr 2018 17:34:42 +0200
In-Reply-To: <20180430141946.12186-1-colin.king@canonical.com>
References: <20180430141946.12186-1-colin.king@canonical.com>
X-Mailer: Evolution 3.28.1 (3.28.1-2.fc28) 
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
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 2018-04-30 at 15:19 +0100, Colin King wrote:
> +       P2P_STATE_RECV_INVITE_REQ_DISMATCH =
> 17,        /*      receiving the P2P Inviation request and mismatch
> with the profile. */

Might as well fix the "inviation" as well, no? :)

Thanks
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
