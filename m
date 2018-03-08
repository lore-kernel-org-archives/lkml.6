Return-Path: <kernel-hardening-return-12252-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELs2qV6dBXug59WvOKjEw3L4Hs7XgcmBpvmYleXPKAx/d6pofhF3i1LP/+dbTomQ0EGuHgXc
ARC-Seal: i=1; a=rsa-sha256; t=1520536847; cv=none;
        d=google.com; s=arc-20160816;
        b=jKwHRENkB9ywAWFz7/IYPwdR7lpNfP2xQpoYUekGWB0ckcsUK+PVxE6ytrq7JRZ40x
         1xNPaEEthnQb742gKvjvIViCdQtm7oGchHRX4mN2pOfWcMqDWz+nWLId0aeT6+Tg+031
         RJKuYQvBqhVwgck6QTgAppTw17jbcjruYNZ4a6Ny4gmrFSpLjYWG7YPP1gPutGAN1InT
         pwWm7RNNVlwkkVRWlVfukD0M3hkjs3GoDvHP2MrB6hP9UBTsrQ2LSWCW2IGdrv3M9zQg
         GxBD/oBOvyZo0GEAzc7cfmMY7gLMO1nnCmpE17FEIq/Tzw0bgaLuO7M0LRHAn5JL8T8+
         Hp1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:mime-version:references
         :in-reply-to:date:cc:to:from:subject:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=Gr0ZDg7fk7B4fk2I5TNzHbQ37FYgt/SS399K0RcN0oA=;
        b=FWdkgDfq1ZBQdMG9jB9z9u3kx4IM9w5TJjdgJBdoMlfyhQlSfB25aRs2kgypIYpC3H
         K7gjYBVNST47n/uLg9SD6NHwFSOGcL2flREnv4/DDEokUS/zOOSCtkdJbZ1hxid8Re65
         q/kSd+N4rMFoLsHhEiUWx69hfnjlKjLfE85/P5Nsw4HGTo8y0kAmCGZPIuXl5cCZbVMM
         OMbNzTOyJL/zTp2XKAslIFUvhIhnYNHxD94Ux6RkzzxZBj09i+Ex7PGVuOHPFWTC6gcT
         823BRxaYT+fwTluqU3GGQu6NC1TEhpX6xXua9y+zvRhHrDisKx+kvRYE83lVBaVn5lfE
         0/GA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12252-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12252-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12252-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12252-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH] ima: drop vla in ima_audit_measurement()
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Tycho Andersen <tycho@tycho.ws>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Dmitry Kasatkin
 <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org,
        Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>,
        kernel-hardening@lists.openwall.com,
        Richard Guy Briggs <rgb@redhat.com>
Date: Thu, 08 Mar 2018 14:20:17 -0500
In-Reply-To: <20180308190431.5fstqsjmbpquzqii@smitten>
References: <20180308171456.2597-1-tycho@tycho.ws>
	 <CAHp75VfoiQ_PxBph8JnNzun4y5Z-9z_rUcjGyM7A2CAwynddeA@mail.gmail.com>
	 <20180308183721.mnsrmhekyfo2dbso@smitten>
	 <1520535030.3605.64.camel@linux.vnet.ibm.com>
	 <20180308190431.5fstqsjmbpquzqii@smitten>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18030819-0040-0000-0000-0000043C8794
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030819-0041-0000-0000-000020DFA8CF
Message-Id: <1520536817.3605.74.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-08_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803080214
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594389722092015419?=
X-GMAIL-MSGID: =?utf-8?q?1594398444814811232?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 2018-03-08 at 12:04 -0700, Tycho Andersen wrote:
> On Thu, Mar 08, 2018 at 01:50:30PM -0500, Mimi Zohar wrote:
> > On Thu, 2018-03-08 at 11:37 -0700, Tycho Andersen wrote:
> > > On Thu, Mar 08, 2018 at 07:47:37PM +0200, Andy Shevchenko wrote:
> > > > On Thu, Mar 8, 2018 at 7:14 PM, Tycho Andersen <tycho@tycho.ws> wrote:
> > > > > In keeping with the directive to get rid of VLAs [1], let's drop the VLA
> > > > > from ima_audit_measurement(). We need to adjust the return type of
> > > > > ima_audit_measurement, because now this function can fail if an allocation
> > > > > fails.
> > > > 
> > > > 
> > > > 
> > > > > +       algo_hash_len = hash_len + strlen(algo_name) + 2;
> > > > > +       algo_hash = kzalloc(algo_hash_len, GFP_KERNEL);
> > > > 
> > > > > -       snprintf(algo_hash, sizeof(algo_hash), "%s:%s", algo_name, hash);
> > > > > +       snprintf(algo_hash, algo_hash_len, "%s:%s", algo_name, hash);
> > > > 
> > > > kasprintf() ?
> > > 
> > > Sure, in fact I think we could just do:
> > > 
> > > -	snprintf(algo_hash, algo_hash_len, "%s:%s", algo_name, hash);
> > > -	audit_log_untrustedstring(ab, algo_hash);
> > > +	audit_log_untrustedstring(ab, algo_name);
> > > +	audit_log_format(ab, ":");
> > > +	audit_log_untrustedstring(ab, hash);
> > > 
> > > and get rid of the allocation entirely. I'll test and make sure it
> > > works and then re-send.
> > 
> > The hash algorithm name is an enumeration that comes from the kernel.
> >  It's defined in crypto/hash_info.c: hash_algo_name.  Why do we need
> > to use audit_log_untrustedstring()?
> 
> Yes, I suppose we don't need it for the hash either, since we're
> generating that and we know it's just hex digits and not any audit
> control characters or "s or anything.
> 
> It looks like we could get rid of the other allocation too by just
> using audit_log_n_hex, but that uses hex_byte_pack_upper, vs. the
> hex_byte_pack that's currently in use in this function. Is that too
> much of a breakage?

Based on the discussion with Richard Briggs, we need to differentiate
between the ima_audit_measurement() and the ima_parse_rule() usage of
AUDIT_INTEGRITY_RULE.  The ima_parse_rule() will continue to use
AUDIT_INTEGRITY_RULE.  ima_audit_measurement() will need to define and
use a new number.  Auidt name suggestions would be appreciated.

When we make that sort of change, any other changes are insignificant.
How different are the two formats?

Mimi
