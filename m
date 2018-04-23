Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1037679-1524481607-2-919149977410106037
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524481607; b=FKJNcOstcZpOlEX46jaGZy4E1PvY1vJGx6HuDxNztVN9F+dC49
    NSPomZC5BBlq/ZicCuEyqF40+hp7vi3d527Q78xkQRUw6mJAYo2/iuUCQBbOEGV6
    FyJ536G3C7IrTqkgP4nds0NnHVHNU0XxneEHVDyPuiatPyvlx7NLkPnsnrMtZcJO
    Pq3HoduT9FBi0xLhDFq+8W9esW/i9lBcUyWWy/zYDyRkY8TBnDiog1tGHqQtlqyW
    5lAQkLxK21+UKyw8Wt3ehRS1/PZ1N+U8l51ZkEf3xlhDsi6c6I9aebgItQckc1yO
    n8dYX1PKPclEW9CGWnwTMOIDJfAOYxfkxHbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1524481607; bh=W9F/keapYo
    IHoXyMgYRX571nx4mUbQS6/JyxxUA5zOU=; b=AN0AoE7mdKcqNdkA8VJPonce4j
    xUk+mnZCqbrQ4VqA6dseTji1oDSGThvjRxQ1tmx4/sMJunRwR7Rnj9ZxdEsBkEI5
    8ZlaEawXxas3+zBelrhf2pR+Zn7X3woxm0kCXM0Xo+C18bTASRaT9+Gw6XRpsmd/
    vpQrcOxXu739LfRjLDi2OnnBduO3Kq3ti+d4UZJMBjc4hFitYwJ47YzT6jxyXsln
    SKDLrGku1EW2hjCTAbM5BkfE9YkDbCkDWiLtGf9eWOiJ6Zy0i4UXu0JmnuAn9xNV
    h9PSa81CjWnKhLVKVgXGhb9rXe/K1aJg3GZThSRquSfjNLdcvD97o+4qgsXQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=diasemi.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=diasemi.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=diasemi.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=diasemi.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNtTpL1WHFi+s1gMpIjunHiRvuEXyQKst2xiHBAHsWrRKt/6mxVVBC49j9Lw9RCZxYxp/cxHvsbzUNXJgRF9CqjEwAjkIa2xI6aj0d5vSi6sq173fauZ
    PaHqHFYRDepCXERP5EaUGdWkmFj/e4686KqBMf/U6Od2Jy9MZ7QjD2/tOUT9XEmoOl85sDUwbKYmyCVIMEcxu84hw97tnVZxK05XSuQGcBtKbg6g9f8Lxhhk
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=QRjQRLzp78EA:10 a=kj9zAlcOel0A:10
    a=Kd1tUaAdevIA:10 a=X3a0BiUdAAAA:8 a=QyXUC8HyAAAA:8 a=_jlGtV7tAAAA:8
    a=VwQbUJbxAAAA:8 a=JKKvIA3pE9C_UxyjNsIA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19
    a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=aWu3muFgq6otJbhCXpL5:22
    a=nlm17XC03S6CtCLSeiRr:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754677AbeDWLGb convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Mon, 23 Apr 2018 07:06:31 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.1]:10008 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754648AbeDWLGa (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 23 Apr 2018 07:06:30 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFKsWRWlGSWpSXmKPExsUSt3Opsa7xvrt
  RBlsWalg0L17PZvHm+HQmi67VO1ksrh3rZbK4vGsOm8Xn3iOMFouWtTJbPFl4hsni9O4SB06P
  Tas62TzmnQz02D93DbvHxnc7mDze77vK5rHzewO7x+dNcgHsUayZeUn5FQmsGRM/HmctWMZfc
  e76DeYGxgk8XYxcHEICSxklOud9Zupi5ORgE7CQmHziAVsXIweHiECGxNZDFiA1zAJLmSXuL/
  vDDFIjLOAtsfXnLHYQW0TAR+LQm3+MELafxN9/M8BsFgFVifO3f4DV8AoESHydcZgdYtlPJol
  VS6YwgSzgFNCXmDglAqSGUUBW4kvjarD5zALiEreezAe7R0JAQGLJnvPMELaoxMvH/1ghbHmJ
  7d9+s0PY9hKv771jgbD1JR49fsQIYRtKrJp2ACpuDlT/hQVivo7Egt2f2CBsbYllC18zQ9wpK
  HFy5hOWCYzis5CcMQtJyywkLbOQtCxgZFnFaJlUlJmeUZKbmJmja2hgoGtoCIxTXSMDS73EKt
  1EvdRS3eTUvJKiRKCsXmJ5sV5xZW5yTopeXmrJJkZgGmAAgh2MEw4lHmKU5GBSEuW9XHs3Sog
  vKT+lMiOxOCO+qDQntfgQowwHh5IEb/peoJxgUWp6akVaZg4wIcGkJTh4lER4U0DSvMUFibnF
  mekQqVOMilLivPYgCQGQREZpHlwbLAleYpSVEuZlBDpEiKcgtSg3swRV/hWjOAejkjBvNsgUn
  sy8Erjpr4AWMwEt7pC8A7K4JBEhJdXAaCq5sK8989tWbSnlb+sebfo2sTDvc93NA5pJXHZsyb
  ama833JXrIVPy/6q79PaOl/ZiSs6D2+eaYmuMn3G66+rRI3zFi2HSrsnSl25n3EyxrJe4Z/Tv
  9c87fyD06aj28Bo5FjJtVdnDlmX02/fAjJuE8R8dSsUfPm+X+Xd8v7TLn9ox9vPdmKrEUZyQa
  ajEXFScCAH5x1d59AwAA
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-9.tower-229.messagelabs.com!1524481587!1226511!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
CC: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sre@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>, Jun Li <jun.li@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: RE: [PATCH v7 1/6] typec: tcpm: Add core support for sink side PPS
Thread-Topic: [PATCH v7 1/6] typec: tcpm: Add core support for sink side PPS
Thread-Index: AQHTwo9uuL+EwiEdW0SU7JmHmFIfzqQM7/QAgACCyOCAALalgP//+gEAgAA8CHA=
Date: Mon, 23 Apr 2018 11:06:25 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337014C1E6D67@SW-EX-MBX01.diasemi.com>
References: <cover.1521799705.git.Adam.Thomson.Opensource@diasemi.com>
 <daf72dd237653e55c0485e930108c19a4996aa4f.1521799705.git.Adam.Thomson.Opensource@diasemi.com>
 <20180422140508.GA21446@kroah.com>
 <2E89032DDAA8B9408CB92943514A0337014C1E6AAD@SW-EX-MBX01.diasemi.com>
 <2E89032DDAA8B9408CB92943514A0337014C1E6B41@SW-EX-MBX01.diasemi.com>
 <20180423082528.GA20868@kroah.com>
In-Reply-To: <20180423082528.GA20868@kroah.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.20.24.43]
x-kse-attachmentfiltering-interceptor-info: protection disabled
x-kse-serverinfo: sw-ex-cashub02.diasemi.com, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 23/04/2018 09:12:00
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 23 April 2018 09:25, Greg Kroah-Hartman wrote:

> On Mon, Apr 23, 2018 at 07:49:38AM +0000, Adam Thomson wrote:
> > On 22 April 2018 21:58, Adam Thomson wrote:
> >
> > > On 22 April 2018 15:05, Greg Kroah-Hartman wrote:
> > >
> > > > On Fri, Mar 23, 2018 at 10:12:20AM +0000, Adam Thomson wrote:
> > > > > This commit adds code to handle requesting of PPS APDOs. Switching
> > > > > between standard PDOs and APDOs, and re-requesting an APDO to
> > > > > modify operating voltage/current will be triggered by an
> > > > > external call into TCPM.
> > > > >
> > > > > Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> > > > > Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > > > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> > > > > ---
> > > > >  drivers/usb/typec/tcpm.c | 517
> > > > ++++++++++++++++++++++++++++++++++++++++++++++-
> > > > >  include/linux/usb/pd.h   |   4 +-
> > > > >  include/linux/usb/tcpm.h |   1 +
> > > > >  3 files changed, 509 insertions(+), 13 deletions(-)
> > > >
> > > > This patch adds build warnings to the tree, so I can't take it, sorry.
> > > > Please fix up and resend.
> > >
> > > No problem. Sorry for that. Will take a look and resolve the warnings.
> >
> > Sadly this is going to be a bit more than 'resolve the warnings' task now as Jun
> > Li's patch set has now made it in before me which means I need to rebase PDO
> > Selection because of his changes. :(
> 
> Someone was going to have to do that, sorry :(

Just as an FYI, this patch will produce warnings until the associated
power_supply interface patch (number 5 in the series previously sent) is
included as that makes use of the new API. Not sure how I can get around that
so I guess we have to wait on Sebastian to give the nod for the rest of the
power_supply patches before this can make it through.

Anyway, will rebase and resend, and will further highlight this reliance in the
cover letter.
