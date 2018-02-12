Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2037081-1518461963-2-14253137478947233071
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518461963; b=FHxqflvVMRyHwkQKUoiUERJNoX8B1YgflPwimfIQs1PiWFu
    4V3djlfVqAGtnrBhiJ2PCRzNuvL3pmmzJ0H7IuTF8XprABjxsGyNZJD8+mOElAYx
    d2zmUugcl+Z4ZcJWoGWQo0Q8DnrEYSHo8GfkpjsMQqkWFzQ2jzKSvw7Ax4ed1CoW
    Q3hlddOUk8DbDa5lyu8plzoy4T4SyHcR94BfyM4kzGuN3pKPFSDGYHW3+YzhmvCY
    NG8sxlmyh69FdmErDcj6syIcEquYL+XXgitu4prCvZobnXweZaApZBE+F4bq8iAw
    i0xaEdOx9ZrYiVY61CeJGJENgp4zlVmSQuUthXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518461963; bh=t
    MFTQQ52nAVNDCFr0cOlImq4Y8Z9hWsIk/hwD7aALrc=; b=ireQ0kjT0LF/4Yal2
    fWQ5FggdsXMjV76bRO3KHqg3ln3Sytllktx6hb0T8HZq/I7uBXjDn3NTgAGGsQsh
    pI5SmoNiKvlMTFKVYUKpMB/bufec5ZIBnPZTS4lxbf4bD+F/Zx7N3JQkCTkP4QXM
    DeXlgK5g2XI5O8NU2W6UYKWQQoLjxT5ZA3BnRE2csPTLd+WDckESFfFi11om90+4
    xrEHCoGyr3+LRin/ntIvWGrZMtGTmjG8SrbR0yabZEnNJoEXxzOmLUcV6gfCERMZ
    bPfytPwwwij6COp6nom7PYd5W95sNPpE4selgqWLk/KOhSZmSZSURpv0GWAid6YU
    MdwOw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=kyTOKowT x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=kyTOKowT x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Mon, 12 Feb 2018 17:57:31 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Himanshu Jha <himanshujha199640@gmail.com>
Subject: Re: [PATCH 2/4] staging: iio: accel: Remove unnecessary comments and
 add suitable suffix
Message-ID: <20180212145731.kws25sjinzqq6ax6@mwanda>
References: <1518436499-8584-1-git-send-email-himanshujha199640@gmail.com>
 <1518436499-8584-3-git-send-email-himanshujha199640@gmail.com>
 <20180212125312.cjo76spuu6agjawc@mwanda>
 <20180212143522.GA12142@himanshu-Vostro-3559>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180212143522.GA12142@himanshu-Vostro-3559>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8803
 signatures=668668
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=850
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802120243
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
Cc: devel@driverdev.osuosl.org, lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, gregkh@linuxfoundation.org, 21cnbao@gmail.com,
 linux-kernel@vger.kernel.org, pmeerw@pmeerw.net, knaack.h@gmx.de,
 jic23@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 12, 2018 at 08:05:22PM +0530, Himanshu Jha wrote:
> But these should be done when we have *more* instances.
> 
> For eg: 
> I added a tab space in function static int adis16201_read_raw() argument
> to match open parentheses in this patch. But I also added tabs while
> removing and adding suitable suffix to the macros. So, should it also be
> done in a separate patch ?

If you're changing a line of code and you fix a white space issue on
that same line, then that's fine.  If it's just in the same function,
then do it in a separate patch.  In other words, adding tabs when you're
moving around macros is fine, but adding it to the arguments is
unrelated.

This patch was honestly pretty tricky to review.

Jonathan assumes reviewers have the datasheet in front of them and I
assume that that they don't.  He's probably right...  But especially
comments like this:

		*val2 = 220000; /* 1.22 mV */

They seem really helpful to me.

regards,
dan carpenter

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
