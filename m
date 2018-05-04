Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3692842-1525411681-2-1379771636345080735
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
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
    1525411681; b=nHhd8kGKU8jRd3hY4wnbi1U/hrrXAMc/IuHQHO6cyt6gNOxmS+
    efEvH47C4t+9kzAQ6/uW/Z8vJQs9wUYfkBe1RqRtepHuiR+mroaUCiY4k6k2uNX5
    ogDZciruV6M3Uk3fQ9X5kiOw17pj1w0LkpkohfhOpMJLYTGCrhP3jL5f7TM7QLPa
    VMzbH629t8TVckh0l0uLqrjcro3cUTIzX/KSpPf39oqaCi9MqLOlrz0yQI4zC3LC
    TxkUmu6+hzUMN2bf0kjScWyJ31pw6iHqwhxnUu051dXDiDC2SesFXUsSGmQj9Lg0
    MsyCFseLvR3s/e9BghapXXQ+1v6IgEasjW2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525411681; bh=+B1DK
    LiII1RQXxz5iVZYN9pTxJXWDTenNN0FuaY+OJw=; b=HgL7YfMI9XJVS5ejN4j/l
    2akaNztZbUD4+y4sXYODK+mPkFqBi9AvnVB2WIYBZMwH2GefgieIuMCgLVYcrk4R
    e2DaKrQGb8pObhXmeREkmsDiQY28e07VE8ZiWETBbChXkNFCAnJYY79/1AzNhJTl
    nFJE3gnvcTijULKahqSNU2f1hUgzEsAhl1gbuKFjTMqAu9oP2xqp/5qZ+MhQi6Pb
    0+wBS8b+UtENq+m+hONkhzDrVqhC+KP2ZQH1B3vxbVuj7bBSl4oamZAsfdxYrMb4
    qot9JLsgeZuFa2nA/Z5lBkqc/HnoQrchoSgR7hpngOpZl59W1/1aTZof4O6sqUBR
    g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=oracle.com header.i=@oracle.com header.b=GzHxCCTT x-bits=2048
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=oracle.com header.i=@oracle.com header.b=GzHxCCTT x-bits=2048
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
X-CM-Envelope: MS4wfGRpgF4sKtyW2IkNH9yiSPaLu2hS+agbb7Ha3VGGKazvdStjYiPLpGre4fu3foSXHL9G3UcKHuXl6J8TMWYI6RUhufLDbI9n4pFw5CC/cCu9Y8rVikb6
    kMIfFsfMNL2LCpvtt1c+hahvKZXy80+9INfu5U0E8ZVV4yKEN1ef7o+k4fW5ph2WNgISwMZ1Sxo/FZgPrfSTxQx1lzCzrxOYyNeMz3Q3PSsUYWk+slpCgrE9
    MsCkCmollLDMYvg8nXr7Vg==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=3Ce91yGrHugya8LvQE8A:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Fri, 4 May 2018 08:27:32 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Wenwen Wang <wang6495@umn.edu>
Subject: Re: [PATCH v2] staging: lustre: llite: fix potential missing-check
 bug when copying lumv
Message-ID: <20180504052731.jkwhs4h4fuia3pft@mwanda>
References: <1525128971-8946-1-git-send-email-wang6495@umn.edu>
 <20180501084621.jfxrm3qoqfmftnxh@mwanda>
 <CAAa=b7dHK9grwfFLOpVv=Wpv32mLS66CxXJDHOzNBNaqsWLXaA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAAa=b7dHK9grwfFLOpVv=Wpv32mLS66CxXJDHOzNBNaqsWLXaA@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8882
 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=747
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805040048
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
Cc: "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
 Aastha Gupta <aastha.gupta4104@gmail.com>,
 Roman Storozhenko <romeusmeister@gmail.com>,
 Andreas Dilger <andreas.dilger@intel.com>, Jeff Layton <jlayton@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kangjie Lu <kjlu@umn.edu>,
 NeilBrown <neilb@suse.com>, open list <linux-kernel@vger.kernel.org>,
 Oleg Drokin <oleg.drokin@intel.com>,
 "moderated list:STAGING - LUSTRE PARALLEL FILESYSTEM"
 <lustre-devel@lists.lustre.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

There is no security problem here.  The user is allowed to choose either
v1 or v3.  Using a double read race condition to choose v1 is not
going to cause problems.  It's slightly more complicated than just
choosing it directly but that doesn't make it a security issue.

It's a bit like typing with your feet in that just because using your
toes instead of your fingergs is more complicated, it doesn't make it a
security issue.

regards,
dan carpenter

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
