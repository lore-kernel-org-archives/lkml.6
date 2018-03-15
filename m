Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-36621-1521110953-2-2635935648098706873
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
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
    t=1521110952; b=ekRujX5Iom6rb/aMdS9WlnczjHHdTDYRImTBaZFPsB/FMni
    ccE/huSpWBT/99a2iAUYStE6gU3ZAGAnnVTgs5wxoiRfhucNR3rXxuPpNd5Jgwxp
    HTUYIYNeGb6g4j9n7E3H9lnHpjgVijnw4QW0m7je5civ6SeZANDcAoPYkp1tGegf
    bnWZmiBSgjQu0wdnpQKE9okU7rmMNQUdVbCnWm+L3bEkygds3gC0XKv2dOjZNkRY
    igoBKq5q6+NRrNNejF+ZKP6JMjSBJ5M2FMuiDqdPzKEpUN9BfleC2Vy0PsFVDf6+
    2L1Q8G0t/93VVKL5/8GrZWWkBgwCxCecYC0wUNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521110952; bh=y
    p9Bj5IokE907XDuWVOGnNuUo+O0Zgsx8xMRttJpzJY=; b=FKlUwwBVM+spZVd8h
    DD50f6PVjzh/te2yTdqmQbyEm+O0PjMaMJjNaKG6I40ece3zY0Mk3guzklLG0Hxm
    YMabIuR9XYAvez5akrpJTHLr9e8R5boNlFKNOnLled632OCucHRggtfzEjdMeA6R
    q0m5WJqfohiB6fD34ginbhxRYx4oCeWPBp6lLpldxeVHHmD5ye7XfxUwCUsJJN/A
    YAmyOGlZbsUr5kr5krzYmLl8SfUrEqZiFhm+gEH70fsPu34AVk3aDr0cJCtbn2Mj
    rLxbJe0IChE7IOKCc7qp/g4P18VnTIUzN+/u1ebXaBwPW+2k9+fGU43TQi4O4U39
    eLRSQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=sLskqL7p x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=sLskqL7p x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Thu, 15 Mar 2018 13:48:53 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: NeilBrown <neil@brown.name>
Subject: Re: [PATCH 00/13] staging: add drivers to support Mediatek mt7621 in
 gnubee-pc1
Message-ID: <20180315104853.bthffdd4hzklzo6d@mwanda>
References: <152105892255.22262.1902152685410223215.stgit@noble>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <152105892255.22262.1902152685410223215.stgit@noble>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8832
 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=680
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803150123
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
 lkml <linux-kernel@vger.kernel.org>, John Crispin <john@phrozen.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This all seems fine.  Generally the requirements for staging are that it
has a TODO, someone to work on it, and it doesn't break the build.  But
some of the patches don't have commit message and those are required and
some of the commit messages are just the changes you have made not don't
describe the actual code...

John Crispin's email is john@phrozen.org.

regards,
dan carpenter

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
