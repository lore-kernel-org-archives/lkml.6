Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2739656-1519903223-2-2153707132881917484
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519903223; b=qGEjtejOGnAxo3L5kWULslTO7TMf6COO+n8rebnkaJBzTL0
    vOy0MdZxz53bz+H0if5TJZEkabsqMMmz2SuhSuOHik2mTQFzt0AXv46nxPTLs8TA
    L5bCMm7D4lp2OnOxc1XujAkBrNJPQ0MSvvO9uH55XJS1/By33cuNIiIDRkmCfQkU
    32e+/gkjS4/JriajzIkTScpQQ+sWZUWjZSMcII7h/XppM2FDdoFKGy6EmNtwUmde
    zgWi0jHsZgf1jZ9SqJR7/VCCPmj3weGhiT8EGQUGk++Kk0QIhal7JW59Cax3EOpT
    w7Moj36aDYq2cdTqG4ONBMkcSv6WR6dgH3bYXWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519903223; bh=D
    LZ91PiXdOhtUOLQYQJaP0kjWe/3XJrJJVOjgLnHoqs=; b=a1tjObsKEjXvGZ8Cl
    VVloa3Puy98tvzhwoR/TMMmO5wnXrP95wYsDQduSNu20ma8xKfEvi71SYxYdGmW7
    L2TnH5SKW5BRm7MWpNisJeXJGlGY0xsN1ywtRREeV7vi05ig4clhXHrmzffbSou/
    fLPkRPqKCDq0oy2JbW/79Em9qeBVXMLFY3neEp7KjQHFbJXdnCT8IX/AmQcUZB9/
    J2RF7XJr7iTQiQ2K+xiLqlDJDTlwg+ur+yVjkHPh0M4khiL1r+ryg7fOsVbqFQAA
    0q4bVx741hz2NHTmnYPhUBZgI7xGcoyF6EMm8Yh3JUmnOa6hXhW0Xunoq8i2AMru
    cvb9w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=MPxjhJPM x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=MPxjhJPM x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Thu, 1 Mar 2018 14:15:00 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: "Tobin C. Harding" <me@tobin.cc>
Subject: Re: [PATCH 3/5] staging: ks7010: Factor out repeated code into
 function 'ks_wlan_cap()'.
Message-ID: <20180301111500.lxge4yqfyi2najt6@mwanda>
References: <20180301051911.1314-1-quytelda@tamalin.org>
 <20180301051911.1314-3-quytelda@tamalin.org>
 <20180301063721.GD4059@eros>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180301063721.GD4059@eros>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8818
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=682
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803010144
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
Cc: devel@driverdev.osuosl.org, wsa@the-dreams.de, gregkh@linuxfoundation.org,
 driverdev-devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
 Quytelda Kahja <quytelda@tamalin.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 01, 2018 at 05:37:21PM +1100, Tobin C. Harding wrote:
> On Wed, Feb 28, 2018 at 09:19:09PM -0800, Quytelda Kahja wrote:
> > The code that generates a WLAN capability mask is repeated in five
> > functions.  This change refactors that code into a new function, which is
> > called now in each of those functions.
> 
> Perhaps in future something like:
> 
> Code to generate the WLAN capability mask is duplicated five times
> 
> Add helper function to generate WLAN capability mask, refactor code to
> use newly defined function.
> 

I honestly don't see the difference between that and what Quytelda
wrote?  I understood the original changelog just fine.

regards,
dan carpenter

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
