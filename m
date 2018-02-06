Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1250620-1517926456-2-2549855519385541666
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517926456; b=b6c5i4IcxcFojWoeFoaOicAXbYxZXaP7pYhgt7XtD6B5BF7
    PzQXLfH5ia4zlqi5BDKXilZSYy18rMB+cet9KovFMSYj5v7G8ls9w4Pirq15aV5d
    dfuaCHjYxz9QuJT0e1FJiyxoIIDTzeaM5eu2Undd2iNogtlpCBKzIH/UjRrRZbCz
    FNCPuu2ey8baUVlrCH4K5l7sW4MzjvuY9kwOKlMsRcCMp4de93gqhGZSnObsXeAf
    jHTV8/FGbT6BormmOWTfko/+LuLFXDBD82mCTZwruZ7fF0QHWM4SSnOAG6Ndbzud
    iPwf1lEDf3BMqfAJ1lXCfQyc+F9yOz068aMYdLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517926456; bh=3CoCvX
    Mz0bN/7wQoA6Q/aR/Nr6b+hRjt1wlR9k63dC4=; b=JmsiYmTxNIGbmNeCGjrDXn
    RNDC3L38ty3HtEQqiokUSXw9B/5lRW9Jypv+RAwClZ0l6fX2bgNEoOIqYZqBqDz/
    rDUTkGPBG2CzXgyWLoQgSaElCPIm2P4KOIuYSMPNZo8mT1l+0Ep6LB7sgOgsxLBz
    6p/vbtaeVZ0Kj8GOeeF8o8sOxwpNZ6CyLO6/xmztP2MLr69DPrEVrgRjHFXHMN8h
    g34UkfxRIulP88AI5Kxjlbps/1EGqp9O/dWvKpdDHXjJfgO5c4Tt83yEKQV4caOw
    PPvi59tJXAUiJ64htdhvmD2B1zfk7M37UOi2mtOgaO3zKKUakObP6rhxeHY2RONQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=diasemi.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=diasemi.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=diasemi.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=diasemi.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751984AbeBFOOM convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Tue, 6 Feb 2018 09:14:12 -0500
Received: from mail1.bemta6.messagelabs.com ([193.109.254.108]:14883 "EHLO
        mail1.bemta6.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751756AbeBFOOL (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 6 Feb 2018 09:14:11 -0500
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFKsWRWlGSWpSXmKPExsUSt3Opsa7Bjso
  og4O/rS2aF69ns3hzfDqTRdfqnSwWl3fNYbP43HuE0WLRslZmiycLzzBZNC54z2JxeneJxZ/n
  t9gcuDx2zrrL7rFpVSebx7yTgR77565h93i/7yqbx87vDewenzfJBbBHsWbmJeVXJLBmPPz+l
  a2gj6Ni7pJ3bA2MF9i6GLk4hASWMko8XNXN0sXIycEmYCEx+cQDNhBbRCBLYvLW5UwgRcwC15
  klVp2/zwSSEBYIlHjx6w4jRFGQxMH7h6AarCSWreoCG8QioCLx9PUbVhCbVyBAYu3NG+wgtpD
  ARUaJvd9kQGxOAXOJldePMYPYjAKyEl8aV4PZzALiEreezAfbJSEgILFkz3lmCFtU4uXjf6wQ
  trzE9m+/2SFse4nX994B7eUAsvUl+hqLIcKGEqumHWCBsM0lJvydyA4xXkdiwe5PbBC2tsSyh
  a+ZIc4UlDg58wnLBEbxWUiumIWkZRaSlllIWhYwsqxi1ChOLSpLLdI1NNBLKspMzyjJTczMAf
  LM9HJTi4sT01NzEpOK9ZLzczcxAuOdAQh2MB5/H3eIUZKDSUmUN3VKRZQQX1J+SmVGYnFGfFF
  pTmrxIUYZDg4lCV6G7ZVRQoJFqempFWmZOcDEA5OW4OBREuEN3QaU5i0uSMwtzkyHSJ1i1OW4
  8eJ1G7MQS15+XqqUOO8UkCIBkKKM0jy4EbAkeIlRVkqYlxHoKCGegtSi3MwSVPlXjOIcjErCv
  A9ApvBk5pXAbXoFdAQT0BE3gsCOKElESEk1MPLvfsqevjXx/ZJF13kFGaO5zQ3XTD2U59e56w
  Tf5MusnGoPqmuKbwbtSBW4YlZsxpzFfXCd8JS/ceJf/31Ltl/YdEvoSKawehZHzuzDPyJlE9w
  vXeC+XNnTerLnxsK0xr5/lkZ3c4pyFzFpyhX8MS5dy5Zp4/zrrueSNyu7GOze6s0Pbrz6WYml
  OCPRUIu5qDgRAGTEhtd9AwAA
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-11.tower-193.messagelabs.com!1517926448!124697829!1
X-Originating-IP: [94.185.165.51]
X-StarScan-Received: 
X-StarScan-Version: 9.4.45; banners=-,-,-
X-VirusChecked: Checked
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
CC: Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Reichel <sre@kernel.org>,
        "Hans de Goede" <hdegoede@redhat.com>,
        Yueyao Zhu <yueyao.zhu@gmail.com>,
        "Rui Miguel Silva" <rmfrfs@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: RE: [PATCH v4 1/7] typec: tcpm: Add PD Rev 3.0 definitions to PD
 header
Thread-Topic: [PATCH v4 1/7] typec: tcpm: Add PD Rev 3.0 definitions to PD
 header
Thread-Index: AQHTg+F3qFeFNjrFtkq2ZsQN1JeHLaOMgfgAgAsfI1A=
Date: Tue, 6 Feb 2018 14:14:06 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337014C1C1519@SW-EX-MBX01.diasemi.com>
References: <cover.1514904982.git.Adam.Thomson.Opensource@diasemi.com>
 <ab71575c23391464262493ae353c098b268116a4.1514904982.git.Adam.Thomson.Opensource@diasemi.com>
 <20180130122134.GA14922@kuha.fi.intel.com>
In-Reply-To: <20180130122134.GA14922@kuha.fi.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.20.24.43]
x-kse-attachmentfiltering-interceptor-info: protection disabled
x-kse-serverinfo: sw-ex-cashub01.diasemi.com, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 06/02/2018 13:23:00
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 30 January 2018 12:22, Heikki Krogerus wrote:

> On Tue, Jan 02, 2018 at 03:50:49PM +0000, Adam Thomson wrote:
> > This commit adds definitions for PD Rev 3.0 messages, including
> > APDO PPS and extended message support for TCPM.
> >
> > Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
>
> Just one nitpick. I noticed that you are exceeding the 80 character
> limit per line in several places in this series, and I many cases it
> does not look like splitting the line would make the code any less
> readable.
>
> But I don't think that is critical, so if there are no other comments:
>
>
> Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Thanks for the Ack. The file, before I updated it, already had lines like this
for similar definitions. With that in mind I'd erred on the side of style (and
readability, at least in my opinion :)) rather than dropping onto new lines as
they weren't going over by a great deal. However if there's a desire for this to
change then I can update accordingly.
