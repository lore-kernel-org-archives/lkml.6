Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-209062-1522719840-2-15517761849985768580
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522719840; b=U2FL0VLCbc35Lk0ciz+sieo6n1OghFRGcpbcpqKSMPubd/Yz5r
    xiLHlpPJ26Tgo1lIQYuSjV4683If5T9LgBiWCRZltgcHUUTBVVhD62RDnOT8V5+b
    242nkMa4qh9U6XjR/59BX1rCipH5qxtunP1UKckU8ujMAhHBzQRRsXBItm1S2hcs
    odiVUgvjDSk+rqBYa7LQuT88FTGvq8GkuYGszNd7d79uzX0FNm8bRGNIhjQfHevt
    Ukul+QXj5LMlof5OXEGbLmSriToQkWAvLO9UrLNslLwFgcapDnbSFIeDGN1y4pRn
    T9k+ean+vS53QftvCu+0RPiKV1BjvHPTFrOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522719840; bh=hot4Z
    D8DJmov09HJXFNn/0nnvRvQbCxxvHV/37k1edw=; b=fcvlNHNX4axvDzk7Ddofu
    5MM+G4OqZauxWUSEj+iAaGbgM11/rMAHcpbgN27efp9tVHE9AFlRRCbp9jb9EJ3C
    n/9NaUArd92bqiQn/C6lM0Hp4tzOOFfgahz1/CX+668n4Wr3GfsLxiyEogG30VQe
    p+xgoxqIzTaYWx/p2MiBcbuvXB/G6dpDu0LBt625hzf9YensCSal8OFNcB70dAAH
    H2XayhtkwCOcx1ji1UISCpsxA4UOa52E1wv0F5FftibFPswISwO4fktDCxRz2U3F
    y6BRvYH90cDcPY1Xy6j8snwnf52CxYL1lzrHs3jnWItK8Nz/wB3FUlxaoeK3eKZ1
    A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=VECYriSA x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=VECYriSA x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMJW+v8AsuTAd+T05X+FUnu9CvXY5LJSwWScpxCkEnD4EPY2cmcKejDMkg/25Cf+5rTKsvXmJ3JaqkenLaqAYl+3gmwHMaBtG8O01myufQ89cLTi5AuQ
    yC5hIfFuRsNxPdrP2CZFC3i3t6WB2fK7OtcQXYzUhgA3foG/lXkqXsXNvzNRY2473Mxrff5X44fiAlCfIzsm9zRYfd+kEFQUkemRSP1u/bM4o17uC9y/nai8
    3iUMcQ03ftiBTn6I66e89w==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Feg6x53VAAAA:8 a=DDOyTI_5AAAA:8
    a=xkZp4qizgPG5vcm7S18A:9 a=bC3luj0-ju_JmWfi:21 a=1BLN3OFPEk1eH3VY:21
    a=CjuIK1q_8ugA:10 a=WvgAEFZ7fBLC38U1N6He:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Tue, 3 Apr 2018 04:43:35 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Quytelda Kahja <quytelda@tamalin.org>
Subject: Re: [PATCH v2 71/75] staging: ks7010: Remove dummy address set.
Message-ID: <20180403014335.cl3pebpnisut2uyf@mwanda>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
 <20180331060855.9452-71-quytelda@tamalin.org>
 <20180331084640.ojo345c5l6ysomav@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180331084640.ojo345c5l6ysomav@mwanda>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8851
 signatures=668697
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804030009
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
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
 driverdev-devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
 wsa@the-dreams.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 31, 2018 at 11:46:40AM +0300, Dan Carpenter wrote:
> On Fri, Mar 30, 2018 at 11:08:51PM -0700, Quytelda Kahja wrote:
> > Setting a dummy address during the driver probe is not necessary.
> > The dev_addr field is already zeroed out from alloc_etherdev().
> > 
> > Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
> > ---
> >  drivers/staging/ks7010/ks_wlan_net.c | 6 ------
> >  1 file changed, 6 deletions(-)
> > 
> > diff --git a/drivers/staging/ks7010/ks_wlan_net.c b/drivers/staging/ks7010/ks_wlan_net.c
> > index 5c5569000fce..afbc472baa05 100644
> > --- a/drivers/staging/ks7010/ks_wlan_net.c
> > +++ b/drivers/staging/ks7010/ks_wlan_net.c
> > @@ -2852,9 +2852,6 @@ int ks_wlan_close(struct net_device *dev)
> >  /* Operational parameters that usually are not changed. */
> >  /* Time in jiffies before concluding the transmitter is hung. */
> >  #define TX_TIMEOUT  (3 * HZ)
> > -static const unsigned char dummy_addr[] = {
> > -	0x00, 0x0b, 0xe3, 0x00, 0x00, 0x00
> 
> Of course, this isn't a zero address.  Do we know why they chose this
> particular address?  I was expecting it to be zero from the patch
> description.
> 
> regards,
> dan carpenter
> 

Quytelda asked me about this patch privately.  When I originally read
the commit description, I basically saw that we're removing code because
the dev_addr was already initialized to zero.  But actaully it says that
we're just removing nonsense code.

So that's fine.

regards,
dan carpenter

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
