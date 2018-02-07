Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3793448-1518002094-2-313439766085606723
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
    t=1518002093; b=ib+runxVBX53DxP6uU+TmUNvtddj2yHaIsUaIgOnQyrH4dH
    t8YyStpghcf/8gdxiNwYzi7wjwkUXp2i9zIQUyg45twDbH96c6MAHos8hdp+uZJa
    siNlZlldLTUDrLTCQzHjY8WV2YC+4+yUj1dsYp0Ja9K2yjNqhaBEV+89JwcGD8KP
    HQBcApZD3rc7r5LEVf8wWASXJoHSvcdBIscVKenM7VxurE3FMy2HNdIXk//OfZHR
    cLNVw2UpLt2l3N237pG5c8fC+y7YRoxtekvoT0op8teluulSQwg8iaTZCoNOUzKo
    oKKd+T/BVaHPoLCy3fTZNMTR7qEacFnW+1YPHwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518002093; bh=9
    /kGABPmTR+SFMrXSwglgLViCXKpcUk5hNOmqS7AOsE=; b=CW7Iy2VpfhgNG77uE
    HSadPB3z7tc9MobMKt+TPxttBFgWPNMH+CfRhPnmLIqRoKYjMzqT0Hz6AHXyCr3R
    kXOUBdEgwzFNUiDja1xofZwsw1IPYvESp3BMIF7Qs3bOh2GacrQv2kwCvDPDdxXq
    mX4CvfH98bUXRJltcLxwTgNj/muWEVvNl/0b8TMfna7AyOdmWWw8u9wcMGuSW5z+
    re8nDJjnjaiDaXhzB9Z6obPHaSxATqUM1rydtO06JC4npTMVWFBNe4lKLfMSukhl
    jVs4eprqazscRGUeKAVBtWdYrG0znHU0oMUyAXdIZ33OnYjHrOYBYrFo7tmmWamz
    AnFzA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=oXFWFbO9 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=oXFWFbO9 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Wed, 7 Feb 2018 14:09:26 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: l4stpr0gr4m@gmail.com
Subject: Re: [PATCH] Update rf_type_definition
Message-ID: <20180207110926.dzokcw2dwlinh2io@mwanda>
References: <1517952214-3434-1-git-send-email-l4stpr0gr4m@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1517952214-3434-1-git-send-email-l4stpr0gr4m@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8797
 signatures=668663
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=600
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802070143
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
Cc: devel@driverdev.osuosl.org, arnd@arndb.de, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, justin@jvreeland.com, hdegoede@redhat.com,
 himanshujha199640@gmail.com, hadess@hadess.net, joe@perches.com,
 colin.king@canonical.com, davem@davemloft.net, Larry.Finger@lwfinger.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is better.  But the subject should say [PATCH v2] and we need a
driver prefix.

On Wed, Feb 07, 2018 at 06:23:34AM +0900, l4stpr0gr4m@gmail.com wrote:
> From: Kangmin Park <l4stpr0gr4m@gmail.com>
> 
> enum RT_RF_TYPE_DEFINITION on rtl8723bs/include/rtw_rf.h
> is different from enum tag_HAL_RF_Type_Definition on
> rtl8723bs/include/HalVerDef.h
> 
> So, update them to be the same reference from
> enum rf_type on rtlwifi/wifi.h which recent version.
> 
> As a result, ODM_RF_TYPE_E needs to be updated as well
> Therefore, it is updated reference from enum odm_rf_type
> on rtlwifi/phydm/phydm_pre_define.h too.
> And update some additional code to check more
> chip versions that resulted from it.
> 
> Also, fixed some space required errors and
> line over 80 characters warnings by checkpatch.pl.

Don't do this.  It's considered unrelated white space change and it
makes the code hard to review.

To be honest, I don't know the code well enough to say if this patch is
a good idea generally...  It seems risky and I wish someone would test
it or a maintainer would Ack it.

regards,
dan carpenter

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
