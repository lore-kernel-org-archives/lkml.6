Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2553705-1520925936-2-5660155026475450467
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520925935; b=N+VmLijBJJyHwRmOHmpJsFiKGm20In9Ipd2upYxdclu/9da
    aMYZSnnBsoouwlWIG5V1O4bvFMv4Aa2QBP8LP7xv47c5RuclLGMlJ0oU/rHHT1Iu
    Oxfw79CJc2OOuBVZ1l5QAwuTUHKA7YTSpe9JfW+3L6QneKxSF1mz7EEuApJvt/IU
    Ge94fa2Drce2cEs3oYtBFFWsp35ZwFEe1IRNE/9lagDCQizcqJ/+9sFEj31aQisU
    Ff8/xeNt35trjBAg8xD8mZyum94cxTBF+ClvP76hAm5SFITTcXVoJj8WpzLKruaI
    G4VZEn2cG5DBInIy92PxSRCuhQpynmka+1v7UTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520925935; bh=6bnje77fhKWhlHYBxldEHl3TgF/K9D2oFiV9D9PA3Ys=; b=A
    PIJB32KHmuCiZzqqU2rsLlS1JnUUuuvmt05atweLF+sQcIwpiZvEZ+0+ikX3qb6F
    0rO1NGjzIm00ge332byNiAdOYOBGDvRQfIWcOvc2E7/zua/RFV/7eGFK4VX3Kse/
    sUuQtbfTkfzSXt5iPugKzuTrETKzfWbI18duAlTsyRK16t+adr4SDlaZDmLaQgob
    cm4OJSotxsE7S7YLyIDdR9I0Ykvbge4mGPwqN2m1j5hzwautRONxB/3VPMoTbuOT
    hGvTdeYiM9JAzO2izoAB5qunDSOkkznE7QIVch+Fau4vyDa3zkMED/z53EcqTQGb
    ctbTAErk49hOxfDm0q76A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=quarantine,has-list-id=yes,d=none) header.from=users.sourceforge.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=users.sourceforge.net header.result=pass header_org.domain=sourceforge.net header_org.result=pass header_is_org_domain=no
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=quarantine,has-list-id=yes,d=none) header.from=users.sourceforge.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=users.sourceforge.net header.result=pass header_org.domain=sourceforge.net header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751971AbeCMHZO (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 03:25:14 -0400
Received: from mout.web.de ([217.72.192.78]:51817 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751808AbeCMHZN (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Tue, 13 Mar 2018 03:25:13 -0400
Subject: Re: [2/2] net/usb/ax88179_178a: Delete three unnecessary variables in
 ax88179_chk_eee()
To: Oliver Neukum <oneukum@suse.com>, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Andrew F. Davis" <afd@ti.com>, Andrew Lunn <andrew@lunn.ch>,
        =?UTF-8?Q?Bj=c3=b8rn_Mork?= <bjorn@mork.no>,
        "David S. Miller" <davem@davemloft.net>,
        Philippe Reynes <tremyfr@gmail.com>,
        Yuval Shaia <yuval.shaia@oracle.com>
References: <b92bebdb-c1dc-a9d3-2e3a-845d8dc4998f@users.sourceforge.net>
 <019cc24b-d9c0-d782-35e8-f9f8be0534db@users.sourceforge.net>
 <1520849038.29340.3.camel@suse.com>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <7d45bd0c-5ab2-a2c0-d746-ef2d859eea08@users.sourceforge.net>
Date: Tue, 13 Mar 2018 08:24:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520849038.29340.3.camel@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:3kW1rPNkD1k5jOHSpGmBF4+oDnsSyNYZ2AldccBWObpe70zw8Pt
 NsmM9VjYL/QLRkWqSWUpDVhG4QER787VzrL9yj98AFd3N2UvAq70aBbygFn5VXuzMwYK7uR
 RymSJGPykBodMTY/Ob8MN+QlNZ4Hs8ILoveSx3NcJqbSUG5TLzoh2XshO+o0A3IM/icEAzZ
 we7jakIljxq3pPM5nQ8XA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/QX5XO2vYD8=:NB1ZTN9Aajn82vjZabOZx4
 G1TqlgeZ6wPpc3BIJTJb87Mk5JUxoiqogUESczASFK8ncACtSpOn7CabQRQILgT1JUy8gf5jv
 35a+4Sy5Gdq98QXZUOlyJIAqJsR1jqLO/taCVVebRPH+lGpnTT0T9qqGUUVwosyFCP2jZ/pTR
 zjx6ERiwD26EQKqtZxB7BCqU/WI0lTYXLOs+jNSUm5tJMABnHWmftTPuYZMyKVjvf5Fg+4aZB
 pa1VSWZHCtbKKDW+5PAtw8Q7G2ug5GuIP2PPa1FbSeApBFz5jljwpNrSZ48VUuY31/DxKCCCz
 AgLB655f+l3BF9aKkDtuXXLjzTYd98MYioZh7lIdCUd5y9Myst6aclKNpydYhPdaJ/fXfA3eD
 tNilvY/ZldJ8NyrCJZgpZHMei1iDyr230ZA8Yyzbe/Ne6rxHOuLXBeeed/LZLgHZFgJEyzlvx
 58mxGkrfxZaqBMLSQ3y5Ho7DyLQgsV3eaGiGMfdyzWefvi8aSvhzWyYmEftd4PAB+gTzzmAjq
 QQTIDt/W605yEr8yIEPMxR4EYRU4amIG+cMqgIXkp0PKow3BZ4rSU2/cSI84XLoxJRnJKP7Vi
 4EsVb0q5i4AJ51sGb0cRYlzno3E2BoE8s24B+U88UQfYQFaXvOTHhCKVYBZLMWG6cy6Xq8pCT
 fzHzdv3KHtDZ5DiVoQZQgzBimXo5NLW0GoeQD3m7eh8iqFY2EmjFyj1f8xivOILjdTjGmAAH9
 iLgSQEnSL3aWrzSFWCfor/xSfOebQ+IsocQoXXGgrn5e5MlMkld+a+PwhqB2/YXled8Yy9uMc
 pesc/koiL4oIMviy2/+yeBZROdQOW7goFfG1adDPhG8E9Jx1O4=
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

>> Use three values directly for a condition check without assigning them
>> to intermediate variables.
> 
> Hi,
> 
> what is the benefit of this?

I proposed a small source code reduction.

Other software design directions might become more interesting for this use case.

Regards,
Markus
