Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3793448-1518000708-2-14911917347024404982
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518000708; b=CglZWzbAgKIRdFwgXAjCqbxPZtxPAHVZP8rpq+2UHk65IH1
    9RBKxyOHa4duucVsh9Kc7/8Ta73rDztc4HCta3DqvuaLQrns97GbrWMkA6Gffnm5
    Ceo8bX2g2oDbQaHnStw2SV32YA39kkFJeo3bI5G8Ypja/nY02FmBA10Mw0eIWjLj
    LkeX+XHtnsbX0b4yAVo+YWzPgHuYNg9FMuiGEjLUBoIpB+yySn9Nfswd6gmyuge4
    RycPeLUDGSFV1pH8+NgXFZaJCjSkhc6XeJnI6xXCiEyU3w73RfNxlkHgmXVDsey0
    pMyfPKw2IZqT2WBZrEzXXlQQU65Q6QVaxL8pOnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518000708; bh=l
    oDYlQtF3GDyP9baHBvvzJHiDJ+as2TvWbCftcO0vNE=; b=RqzJ30/QyMKp76HGL
    jgUP/s9EjwK7yZNJbIsmlH++q6x9cuC1P9pk8LgD52tYxte/ohhjruWYXg9TWjIE
    +BhbBrz4WMQVfNH10pqF5FwxftF6g29Jz1LcT18bBNL123Yi2F1+1DrHkkUO2Yhy
    ccKXIKitMh09tJbGY8kFmZMH3WohgVdxDLHACfXNpay1ihnHK00h93zcwZOJw5uh
    G/MfQF0RmzgYNIwYgrTPyxVIXUZsiz7tXwO/+lY6aKv74N0tMUYafwMLW0VDrBgi
    G81Ob9M8v91l0ObX1/JJTTeZATP6Q1m+4ejfrzO0w1vzLHQ21XmVWOtuqdBumF4F
    rL1rQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=vhbXywI6 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=vhbXywI6 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Wed, 7 Feb 2018 13:51:11 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Kangmin Park <l4stpr0gr4m@gmail.com>
Subject: Re: [PATCH] Resolve RF Type mismatch
Message-ID: <20180207105111.mle4uuq6ywj5yu26@mwanda>
References: <1517932633-7832-1-git-send-email-l4stpr0gr4m@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1517932633-7832-1-git-send-email-l4stpr0gr4m@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8797
 signatures=668663
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=537
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802070137
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
 hadess@hadess.net, joe@perches.com, davem@davemloft.net,
 Larry.Finger@lwfinger.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 07, 2018 at 12:57:13AM +0900, Kangmin Park wrote:
> From: pr0gr4m <l4stpr0gr4m@gmail.com>

No changelog, no sign-off.  Changelogs are required but especially in
this case, it's not immediately obvious what this patch is about.

This patch has unrelated white space changes as well.  Here is how the
rules work:

> -	ODM_1T1R	=	0,
> +	ODM_1T1R		=	0,

This are unrelated.

This white space change is on the same line so that's fine (it's
related).

> -	else if ((rf_type == RF_1T2R) || (rf_type ==RF_2T2R))
> +	else if ((rf_type == RF_1T2R) || (rf_type == RF_2T2R) || (rf_type == RF_2T2R_GREEN))

regards,
dan carpenter

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
