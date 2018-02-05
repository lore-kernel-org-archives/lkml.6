Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752832AbeBEMKa (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 07:10:30 -0500
Received: from smtp-out6.electric.net ([192.162.217.189]:55294 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752574AbeBEMKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 07:10:21 -0500
From: David Laight <David.Laight@ACULAB.COM>
To: "'Boris Ostrovsky'" <boris.ostrovsky@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>, Juergen Gross <jgross@suse.com>
CC: Nicolas Pitre <nico@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        "Dan Carpenter" <dan.carpenter@oracle.com>,
        Jan Beulich <jbeulich@suse.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] xen: hypercall: fix out-of-bounds memcpy
Thread-Topic: [PATCH] xen: hypercall: fix out-of-bounds memcpy
Thread-Index: AQHTnH5MZeMmOwTXYkSEccagX73Jx6OVu3wg
Date: Mon, 5 Feb 2018 12:11:07 +0000
Message-ID: <1eddce614f604c518b9bf238a2f92e4b@AcuMS.aculab.com>
References: <20180202153240.1190361-1-arnd@arndb.de>
 <aa6e25c7-dc55-a5bf-39cb-8b9453604111@oracle.com>
In-Reply-To: <aa6e25c7-dc55-a5bf-39cb-8b9453604111@oracle.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-Outbound-IP: 156.67.243.126
X-Env-From: David.Laight@ACULAB.COM
X-Proto: esmtps
X-Revdns: 
X-HELO: AcuMS.aculab.com
X-TLS: TLSv1.2:ECDHE-RSA-AES256-SHA384:256
X-Authenticated_ID: 
X-PolicySMART: 3396946, 3397078
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w15CAX1w013075

From: Boris Ostrovsky
> Sent: 02 February 2018 23:34
...
> >  	switch (cmd) {
> > +	case EVTCHNOP_bind_interdomain:
> > +		len = sizeof(struct evtchn_bind_interdomain);
> > +		break;
> > +	case EVTCHNOP_bind_virq:
> > +		len = sizeof(struct evtchn_bind_virq);
> > +		break;
> > +	case EVTCHNOP_bind_pirq:
> > +		len = sizeof(struct evtchn_bind_pirq);
> > +		break;
> >  	case EVTCHNOP_close:
> > +		len = sizeof(struct evtchn_close);
> > +		break;
> >  	case EVTCHNOP_send:
> > +		len = sizeof(struct evtchn_send);
> > +		break;
> > +	case EVTCHNOP_alloc_unbound:
> > +		len = sizeof(struct evtchn_alloc_unbound);
> > +		break;
> > +	case EVTCHNOP_bind_ipi:
> > +		len = sizeof(struct evtchn_bind_ipi);
> > +		break;
> > +	case EVTCHNOP_status:
> > +		len = sizeof(struct evtchn_status);
> > +		break;
> >  	case EVTCHNOP_bind_vcpu:
> > +		len = sizeof(struct evtchn_bind_vcpu);
> > +		break;
> >  	case EVTCHNOP_unmask:
> > -		/* no output */
> > +		len = sizeof(struct evtchn_unmask);
> >  		break;

Are the EVTCHNOP_xxx values dense?
In which case an array is almost certainly better than the switch statement.

	David
