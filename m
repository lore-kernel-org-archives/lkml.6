Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-878196-1526307340-2-17067676057849203560
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526307339; b=S0v7y7KGmdZXTPv00mp7M5pFgkRAa0BO5plpwpaafbLIs53+yI
    +jF3ylImF/aldHb7JHApO7pF2zQF74w7AOniJX7qnTXXivSWW2UhK3zVGhnaF/jI
    goi3BSBIUE7P5S/PxIGuzgo/UoGc1GCANEGsRtcXheL2lDTLwy/HtOuyo/0U9SBD
    O8kRUeqH6dZQ5ksnpUUGgJGzjO84IIX8xWzrcjY1Pp9ZCc8wrdnL9zsVnduDqrUU
    0FVOkTWyhrIjhfpaM/ejBehJJGTkr0MNfoRzulWXnFBoQvpqqe6qbBq7tPtYZ5md
    VL+pJz3s9lwhi6+Sn2YUM1RQbVXlV4BfKDlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526307339; bh=4R6so
    cz3qdysI+Kr/HVylW8GGt/eBrW8gUbPiD02+l0=; b=k4NlCxsGBY8TSPgVqUx/b
    dh67DG1oILFxA7lgEiySArsZIi3PBqWeM8rxclXRR72+nGawE2nUu3FpiOrN7LDz
    mciFwIGSr+jVg1Cbe4FBWZ+AHQOi5eOJif26wC75D21hlJR/AFogOOYwj9mFbhl/
    m1A7O3dw4KsZdT9bcFbko+nocNCBDP5patNJ3adccs7wkSPDSmNhDzj2fLmG95M3
    595k+7v39Fw2dX9aJE4vjbIp4txjrzXeTlTRa9XxoNOL7I9yUwRPx70Qs+dpuSxq
    Jj2+4khhrzmvoB6HbyPkUu+vrJ+VemhmMFl4PMN3vjRcxFJ3n8KkgiYi0xxLmR+s
    w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=oracle.com header.i=@oracle.com header.b=vs8BfMhs x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=oracle.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=oracle.com header.i=@oracle.com header.b=vs8BfMhs x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=oracle.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfH8p/YGMYtnt5bjBZgtP/aCDb171qisXlipFiM6ZdHZRVDpjEujJFXyjPDS78499Izk07Ju3hyv2hmh3kLlujHIQ5ZSiCh4E8DNRdEdhBFq/xjBgtkiK
    2DgAqmkIg1AGa8hYF39zIhxl7+XLBIYCX7T3m/3Ky3PepVQSyuhp8PNlBEa4M7fVx/hCFI3M8NkO27A7cNSFF5YjH1xpUP+FNJIbdOFU3k9lKxlpjW+br+to
    pW+GV06VFPSbmDdYFXJk5w==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8
    a=MrpjD6tbk4KP56SmzpMA:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Mon, 14 May 2018 17:15:23 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH 3/7] staging: ks7010: Remove unnecessary limit checks
Message-ID: <20180514141523.tmc3yfad5wj2vkop@mwanda>
References: <20180506220304.13040-1-natechancellor@gmail.com>
 <20180506220304.13040-3-natechancellor@gmail.com>
 <20180514131736.ysftvs3nk552kjnx@mwanda>
 <20180514140622.GA13207@flashbox>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180514140622.GA13207@flashbox>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8892
 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805140147
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
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 14, 2018 at 07:06:22AM -0700, Nathan Chancellor wrote:
> On Mon, May 14, 2018 at 04:17:36PM +0300, Dan Carpenter wrote:
> > On Sun, May 06, 2018 at 03:03:00PM -0700, Nathan Chancellor wrote:
> > > uwrq is an unsigned 32-bit integer, it cannot be less than zero.
> > > 
> > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > ---
> > >  drivers/staging/ks7010/ks_wlan_net.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/staging/ks7010/ks_wlan_net.c b/drivers/staging/ks7010/ks_wlan_net.c
> > > index e96477937f65..0c83d6fe270f 100644
> > > --- a/drivers/staging/ks7010/ks_wlan_net.c
> > > +++ b/drivers/staging/ks7010/ks_wlan_net.c
> > > @@ -1928,7 +1928,7 @@ static int ks_wlan_set_beacon_lost(struct net_device *dev,
> > >  	if (priv->sleep_mode == SLP_SLEEP)
> > >  		return -EPERM;
> > >  	/* for SLEEP MODE */
> > > -	if (*uwrq < BEACON_LOST_COUNT_MIN || *uwrq > BEACON_LOST_COUNT_MAX)
> > > +	if (*uwrq > BEACON_LOST_COUNT_MAX)
> > 
> > I believe Smatch is supposed to ignore this sort of code because
> > comparing "if (foo < 0 || foo > max) " is pretty readable and idiomatic.
> > 
> > Presumably this was so we could redefine BEACON_LOST_COUNT_MIN, but it's
> > fine to unused code.  The define isn't needed at all, so you can
> > delete that as well.
> > 
> > regards,
> > dan carpenter
> > 
> 
> Hi Dan,
> 
> Thanks for the suggestion, I just sent a patch.
> 
> This warning came from GCC as a -Wtype-limit warning. I should have put
> that in the commit message to be more clear. I will keep this in mind
> for the future if I come across any more checks like this with defines.
> 

Anyway, please delete BEACON_LOST_COUNT_MIN entirely.

regards,
dan carpenter

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
