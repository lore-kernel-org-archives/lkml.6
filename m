Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1311000-1517927609-2-12371259338237237013
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
    t=1517927609; b=TZPH4rDMoJ21eHPyxF9ATTWzAskA/VoKRlnCdoFdkDsxer7
    2IU3cj0dBtbHpx6e9O+Jogr/z2lcqliwGO3oOl8aQ3bDrIffMsZLoXb68nSBzfKk
    eLwu50r42TnXqbjWBa0s4CBsZ4h4xp6+fHX+7FJoswAXWLW8fjm7vmpHODMmOCbG
    oV1CEMno0ug67xez3DV9q86xy+8nILyFVguODzT8SWUbv8py4xopSs2Fa14aZyZl
    HMYsFgGj9+u5vcggbTPTgAlqo8UwuVtAelACmM7BW5F+55i2YUqHLboMyhlBONHa
    as3TlpB1RP1LSDYTZ37PVZ1EsGd11/JEuEZY71g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517927609; bh=KZvIP6
    TOwT1XleL7Cwc96FsNw7koT+XKlekV6o5i7E0=; b=TlxnI03jZ2NuyNt2ggVhWn
    xcCub2QBXVH+MZKqIfHRRUv3nGtBhGLMT2mRgwvolCZ1u04SU18P1uVWhD7vk16B
    kDGWtJQgK8Wx2Tm1ZDLZy+tLVl7XHHChcUf6ulW/ERdWifEhNI3fUwQ42lSECVP0
    LearWfsqx0Cz4t1J/EcJ/WRHW5BeMpS6t2oFjnTWCMv5n+xw7us2h2zimPPQHsZ+
    Z3N7mCbHVRczQyig5jnCsuNsolHsF2LPVq7pl8vwcnVB5wDJRjalXioHbJTNVshU
    nVY55aBINc2eyzvbUAM4LCj6xH36m40nprNT8SFErSJalcotrwWVsltqLbIqVtSw
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=diasemi.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=diasemi.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=diasemi.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=diasemi.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752214AbeBFOdP convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Tue, 6 Feb 2018 09:33:15 -0500
Received: from mail1.bemta5.messagelabs.com ([195.245.231.139]:16374 "EHLO
        mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751991AbeBFOdN (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 6 Feb 2018 09:33:13 -0500
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJKsWRWlGSWpSXmKPExsUSt3Opse6yPZV
  RBktXqVk0L17PZvHm+HQmi67VO1ksLu+aw2bxufcIo8WiZa3MFk8WnmGyaFzwnsXi9O4Siz/P
  b7E5cHnsnHWX3WPTqk42j3knAz32z13D7vF+31U2j53fG9g9Pm+SC2CPYs3MS8qvSGDN+LRpO
  lvBTMGKF40vmRsYr/B2MXJxCAksZZS40jSHrYuRk4NNwEJi8okHYLaIQJbE5K3LmUCKmAWuM0
  usOn8fyOHgEBbwlui6EAtiigj4SFzvz4Iot5JovnaNBcRmEVCRmHnwHdgYXoEAiQ//Opghdl1
  klNh2agI7SIJTwFxi8b0DTCA2o4CsxJfG1cwgNrOAuMStJ/PB4hICAhJL9pxnhrBFJV4+/scK
  YctLbP/2mx3Ctpd4fe8dC8g9EgL6En2NxRBhQ4lV0w6wQNjmEhP+TmSHGK8jsWD3JzYIW1ti2
  cLXzBB3CkqcnPmEZQKj+CwkV8xC0jILScssJC0LGFlWMWoUpxaVpRbpGpnqJRVlpmeU5CZm5u
  gaGpjq5aYWFyemp+YkJhXrJefnbmIERns9AwPjDsZd7X6HGCU5mJREeVOnVEQJ8SXlp1RmJBZ
  nxBeV5qQWH2KU4eBQkuDds7sySkiwKDU9tSItMweYdmDSEhw8SiK8ZsDUI8RbXJCYW5yZDpE6
  xajLcePF6zZmIZa8/LxUKXHevyAzBECKMkrz4EbAUuAlRlkpYV5GBgYGIZ6C1KLczBJU+VeM4
  hyMSsK8Z0Gm8GTmlcBtegV0BBPQETeCwI4oSURISTUwGqtt/u72cnXA0qbW8mutKuGZMnOf/W
  j84beqJmJm/aHM/IC5p6fe/mnVJ2l0+6nJCrvZMzY2NagI/A09WFW9zEC45OsMtszGNvPlyb6
  FalkvT73aB8wVWw9LG92YvJr1DG/dcbP+voQftRMW/ORyt33wOW33j7eNGza1ihlVvXI0Y5yq
  zJKixFKckWioxVxUnAgAtNoncnwDAAA=
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-11.tower-178.messagelabs.com!1517927590!99693730!1
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
Subject: RE: [PATCH v4 4/7] typec: tcpm: Add core support for sink side PPS
Thread-Topic: [PATCH v4 4/7] typec: tcpm: Add core support for sink side PPS
Thread-Index: AQHTg+F4vgCIVqq8V0+PidDSKbCaNKOMiQuAgAsd1sA=
Date: Tue, 6 Feb 2018 14:33:08 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337014C1C1538@SW-EX-MBX01.diasemi.com>
References: <cover.1514904982.git.Adam.Thomson.Opensource@diasemi.com>
 <26195a73c6f2f379b47dd39f23db9c2feec20371.1514904982.git.Adam.Thomson.Opensource@diasemi.com>
 <20180130124653.GD14922@kuha.fi.intel.com>
In-Reply-To: <20180130124653.GD14922@kuha.fi.intel.com>
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

On 30 January 2018 12:47, Heikki Krogerus wrote:

> > +static int tcpm_pps_set_op_curr(struct tcpm_port *port, u16 op_curr)
> > +{
> > +	unsigned int target_mw;
> > +	int ret = 0;
> > +
> > +	mutex_lock(&port->swap_lock);
> > +	mutex_lock(&port->lock);
> > +
> > +	if (!port->pps_data.active) {
> > +		ret = -EOPNOTSUPP;
> > +		goto port_unlock;
> > +	}
> > +
> > +	if (port->state != SNK_READY) {
> > +		ret = -EAGAIN;
> > +		goto port_unlock;
> > +	}
> > +
> > +	if (op_curr > port->pps_data.max_curr) {
> > +		ret = -EINVAL;
> > +		goto port_unlock;
> > +	}
> > +
> > +	target_mw = (op_curr * port->pps_data.out_volt) / 1000;
> > +	if (target_mw < port->operating_snk_mw) {
> > +		ret = -EINVAL;
> > +		goto port_unlock;
> > +	}
> > +
> > +	reinit_completion(&port->pps_complete);
> > +	port->pps_data.op_curr = op_curr;
> > +	port->pps_status = 0;
> > +	port->pps_pending = true;
> > +	tcpm_set_state(port, SNK_NEGOTIATE_PPS_CAPABILITIES, 0);
>
> Why not just take the swap_lock here..

I believe this would result in deadlock. All of the existing uses of swap_lock
acquire it first before the port->lock is then acquired (and vice-versa for
unlock). We don't want the power role to change during this procedure, so we
hold the swap_lock for the whole process. Have a look at tcpm_dr_set() and
tcpm_pr_set() as examples of existing usage.

> > +	return ret;
> > +}
> > +
> > +static int tcpm_pps_set_out_volt(struct tcpm_port *port, u16 out_volt)
> > +{
> > +	unsigned int target_mw;
> > +	int ret = 0;
> > +
> > +	mutex_lock(&port->swap_lock);
> > +	mutex_lock(&port->lock);
> > +
> > +	if (!port->pps_data.active) {
> > +		ret = -EOPNOTSUPP;
> > +		goto port_unlock;
>
> Or, on top of what I said above, you could actually consider releasing
> the port lock here and just returning. Then you would not need those
> port_unlock and swap_unlock labels at all..
>
>                 mutex_unlock(&port->lock);
>                 return -EOPNOTSUPP;

Based on the comment above, I don't think this makes sense as you'd still need
to release the swap_lock as well, so there would be quite a lot of duplicated
code. Would prefer to stick with the present implementation.
