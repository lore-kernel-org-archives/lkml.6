Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-110966-1520853287-2-18057132885808567832
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520853287; b=Yw9+8ZC8NfBoSEXxBPF9MpF1yelkhq08GZwrszVsppeOZLN
    FLncyvHX715Ft6zSXbAyviuDEB3MDFdXN2XIyZx9RDOZ3Y94SLfrqLBc/a2d9sKg
    Ox2DvpfOr6z7T2kLWWqJ+xBqZtV4nv+2K//5FehAOtcf1bT398FP0KUMW3gzK7b0
    BwLnHgO3WLSfv6xxunYbIalTe9+gcdyee/N63DCf69HFThfIf/sEMk1kZaEGeIXU
    C8eBJ0XsSB55kN9sRs1f3u9TnbAobYSNL1rIHljzsw6+ELtxoOFjrj5gDOKfyGpU
    xQvSMBICk2nU+oJyri6WZ1kJMNqD1eGZ/4zlrnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520853287; bh=S
    n1DnbQhDNZno+Xh0RmEOZ8PumkOrWg/3HpUs7kmKW8=; b=Mvobf9f/JQnLhh32q
    QAo+WgX7jQO2CBYA2R/jgCzie1+HYvJJL/ahHjkyzMomE8IZnRPlgOpwgQ52J2V2
    9LPC/VlJCPQGExxYL1OM1OKpG4Wnmtsgbg1oaN0cIkC321/VWPIcwczTsWGFXuMv
    qVl0E+SZ7xCs6rzM9KxbBpefFgwnIfkO4MAwCixKF7QIjRQ1N7k640Q09pbec0Tn
    AZ1Cie1lq5K+42sw0LK3C3aQZKS2DufEnrQMRglSfHsx1HswkQ0QKYxx6jnM7Vjo
    Ftz7sU/35sPlK6rvty/oNChUc2CGUtAB0139yZEEhIENU121YlAhdQ2m3s9oxQXt
    Lcczg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=Yb1B73jp x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=Yb1B73jp x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Mon, 12 Mar 2018 14:14:22 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH v2] staging: vchiq_arm: Clear VLA warning
Message-ID: <20180312111421.zckzwhspwgcq2vpi@mwanda>
References: <1520818673-14084-1-git-send-email-me@tobin.cc>
 <20180312054613.GG8631@eros>
 <1166411830.411906.1520834284931@email.1und1.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1166411830.411906.1520834284931@email.1und1.de>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8829
 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=985
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803120132
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
Cc: Tycho Andersen <tycho@tycho.ws>, Kees Cook <keescook@chromium.org>,
 kernel-hardening@lists.openwall.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 driverdev-devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
 Eric Anholt <eric@anholt.net>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 12, 2018 at 06:58:04AM +0100, Stefan Wahren wrote:
> Hi Tobin,
> =

> > "Tobin C. Harding" <me@tobin.cc> hat am 12. M=E4rz 2018 um 06:46 geschr=
ieben:
> > =

> > =

> > On Mon, Mar 12, 2018 at 12:37:53PM +1100, Tobin C. Harding wrote:
> > > The kernel would like to have all stack VLA usage removed[1].  The ar=
ray
> > > here is fixed (declared with a const variable) but it appears like a =
VLA
> > > to the compiler.  Also, currently we are putting 768 bytes on the
> > > stack.  This function is only called on the error path so performance=
 is
> > > not critical, let's just allocate the memory instead of using the
> > > stack.  This saves stack space and removes the VLA build warning.
> > > =

> > > kmalloc a buffer for dumping state instead of using the stack.
> > > =

> > > [1]: https://lkml.org/lkml/2018/3/7/621
> > > =

> > > Signed-off-by: Tobin C. Harding <me@tobin.cc>
> > > ---
> > =

> > Drop this please, leaks memory.
> =

> except from the leak, did you test this patch on a RPi?
> =


Hm...  Yeah.  It looks like we're holding a mutex when we call
vchiq_check_service() from vchiq_queue_message().

regards,
dan carpenter

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
