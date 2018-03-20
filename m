Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1258392-1521545418-2-7934029098105034316
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521545417; b=qhXX98IP0jjf+C24J7f0K8BNcr8fSSt2oIfz+H9rFNcgQ2c
    L4dyxAbCzn+dyYJmF5MLa1nee+k+FWRFzH+sjkhZzFW+oB7I/9ZJHgkHsfdaTtms
    bVC089uXnzViGt0T90jtvKPAvOoYpsoWD+y+4l58c5zSnCUePqOcT2PWHPFBA7cf
    Zv4whVX9cDEYt8OKDaS/9uaDbYLzu/zQRvly/FYiqAaaqkd9MWeHIp2QYCVvy8ph
    6LkbVRl6/7S4QvDuQaCipVNyZf3+T47tb/YkbaHMHOD+meRlubSv0Kfv4sp5vdcS
    xeBELrlb9+bSSTp6spbQuX8FGWzmKI2H07OVWVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521545417; bh=2
    yq0KpTRRpWDOJzGLZSGBn5WbexOIkPfcWzAhEaMSPY=; b=TkH+JDeB3AxedvxX+
    BhmKgWL42hhvi0sw/EsdqFHmYjFOv1K8kNwGZNq9OHsGSIM6qKpgHh8BVFsuD75h
    rkDHFKPrFfWgpsnPqrWagnVz0zZCLzSikxcuFtUCvc23L4yc/cZmadEiChJggMnT
    jiPp4R+YCSfxxzaoo21FJ6CE/DEUqCXDEi36xHZHB8Fi7/qWrEr7KdKVvYD+vZmc
    nrOcyZ73DxCtK3cYA6syX36KeTjSxymsoBiGh/+OcNr1Y1CtKtsZ87CraFQBt1ye
    cmdz6XIBe0jzR35WLBW1EN+bu/fHlNbyZIVw+/w1HuBeaxFa7qLFkAt8G0KfUnVl
    +ikPw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=obQPJm8g x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=obQPJm8g x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Tue, 20 Mar 2018 14:29:51 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: "<Hariprasath Elango>" <hariprasath.elango@gmail.com>
Subject: Re: [PATCH 5/7] staging: wilc1000: replace switch statement by
 simple if condition
Message-ID: <20180320112951.wgrd76pxsu3qgk6r@mwanda>
References: <cover.1521030891.git.hariprasath.elango@gmail.com>
 <2a46a5cc8ab69c1143c480bbac1f7e921011d982.1521030891.git.hariprasath.elango@gmail.com>
 <20180319184546.GA17337@kroah.com>
 <20180320061227.GA4866@hariprasath>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180320061227.GA4866@hariprasath>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8837
 signatures=668693
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=828
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803200127
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
Cc: devel@driverdev.osuosl.org, Greg KH <gregkh@linuxfoundation.org>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 ganesh.krishna@microchip.com, aditya.shankar@microchip.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 20, 2018 at 11:42:27AM +0530, <Hariprasath Elango> wrote:
> On Mon, Mar 19, 2018 at 07:45:46PM +0100, Greg KH wrote:
> > On Wed, Mar 14, 2018 at 06:15:03PM +0530, hariprasath.elango@gmail.com wrote:
> > > From: HariPrasath Elango <hariprasath.elango@gmail.com>
> > > 
> > > In this case,there is only a single switch case statement.So replacing
> > > by a simple if condition.
> > > 
> > > Signed-off-by: HariPrasath Elango <hariprasath.elango@gmail.com>
> > > ---
> > >  drivers/staging/wilc1000/wilc_wfi_cfgoperations.c | 8 +-------
> > >  1 file changed, 1 insertion(+), 7 deletions(-)
> > 
> > Does not apply to my tree :(
> 
> Hi Greg,
> 
> Sorry about that.

Probably there were other patches on the list that were applied first.
It's likely not your fault, but just part of the process.

> Shall I sent a v2 after rebasing my repo ? Will that
> be fine ? 

Yes.

regards,
dan carpenter
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
