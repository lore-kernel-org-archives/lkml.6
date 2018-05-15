Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2507959-1526385663-2-1538365074589006155
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001,
  LANGUAGES enrofr, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526385662; b=csCDz6DBAmPJz93Iv8XrNp7qzWzAEZMSKCbWsq+ynLdrqgH+FD
    Dcq7szflzRqhxZQSP/gDKgiLrqKxPoVmEpL621DIwb+ZfMylAofw+x90ueh+bZgt
    T96vCcBh8oOeyDtf72951XA7HJoKavL9ncwyQnWmlm0ipquTexTUdNRgtEp/xDkZ
    LbitUdZcCAebkSyjGU2xEZ86jmQZzbr1/PhHoFHn5yfL5VpdFXqkya+8Y/pq/een
    IevOvgOJ3IxsQPalxsEC14q3NR6s0taoLdP4tzS080jfIBfh+CwXDjB55b/PDizJ
    yctKlZxVJ+QXWMi31LKyIlUhno9pKE0nNxLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526385662; bh=FqE49
    G0dQXsMymtQ8BtocilpMjohmJNYffT5utdqBlY=; b=UQ/ZceV+oArK1923GGKeW
    srFFmdJBMLAu3fN0WBmqFtUGjT53Nr8+gMQ437e4qE2ORwHyEj+EzX6qyP49GkYk
    +PcSLIbtBNwRQv7OUn2rhnJLTYaNwuwb9BqciwAJ4ylwfnfVqQPB7fQJL1+1tOrJ
    Y1KFxBmE7nehYjY7JWhh0D95oKvTBJ7BdRgW8pC2gkFcQgJeMTnxHCy6dHfyQglR
    1OgEffMJatVV+aJA04cjHGoGXkXhPxS83S7PfLLOsSep7hcV7+ilCO08mfL+JqOr
    lT9inDkLKgTqUHTHTMawtNyXurNzbbBVYAkAA13PMcD7vCA0heoFEKXbZRm2aC44
    Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=oracle.com header.i=@oracle.com header.b=XEmX2qqy x-bits=2048
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
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=oracle.com header.i=@oracle.com header.b=XEmX2qqy x-bits=2048
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
X-CM-Envelope: MS4wfDeqqH76buyyMolEPKwAFA9byr1clY3dWAcsPMq2wA1v6StXuYy/Rwiy46TOvRV4WLa2JxlShOkQ+FCAhFegK/tYwNqAPSI6HN15Y89aic8+S+g3yZFw
    LSdORshV+m603izaumzhFRoza5pQxTdPVG8/5plChhiSzPghyxsPRhzZLCtZZgXMJMqRn4YUbG7Rf+DoXK62B2dxX5FDvXbHZo4oHqage1oGD021FBY0LWHd
    OgTlGIE+X4gJHU/35x3kzQ==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=m8YGQp87AAAA:8 a=DDOyTI_5AAAA:8
    a=iM9nulMVCK8VhSV8khsA:9 a=CjuIK1q_8ugA:10 a=sQmdjVoOy41DRvcrsFdt:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Tue, 15 May 2018 15:00:24 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Greg KH <gregkh@linuxfoundation.org>, w.d.hubbs@gmail.com,
 chris@the-brannons.com, kirk@reisers.ca, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, speakup@linux-speakup.org
Subject: Re: [PATCH] staging: speakup: use true/false instead of 1/0
Message-ID: <20180515120024.ckou35hme2uhfz33@mwanda>
References: <20180514205725.hamsvxkhic2gvnfn@var.youpi.perso.aquilenet.fr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180514205725.hamsvxkhic2gvnfn@var.youpi.perso.aquilenet.fr>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8893
 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=959
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805150124
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 14, 2018 at 10:57:25PM +0200, Samuel Thibault wrote:
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

Greg doesn't accept patches without a commit message.  Just say which
tool warned for example.

regards,
dan carpenter

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
