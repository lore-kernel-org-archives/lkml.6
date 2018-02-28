Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3370786-1519800323-2-8893852885395757569
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
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
    t=1519800323; b=TUnkan9PbUWIpEMGZ9LdDwWGeihYVrrnw+C4TmoW7uRoO4D
    CvfbJ4veUm2qVtDHmK37/cwk8WFDcPP/n+WzGa3UJCvQEi2961brP1bLYav4a8eo
    n/699NPedAPTfC2puRCwMYUZEQ9w2Y1ydUI7oHkxsjnDopNsFhcBAFsOVpJslB9x
    dkCL5Ie6vNvmh8eDcmV2QmFdcs+Gai1j2BGaHB39LDcNkt3mSlWQjIHlPJph6CEK
    Nk30wpTf7ahN4mZAmVoqhdlFue+oght1CkYDfsrti7vWFz2g/ySBesPL3LlWibPS
    49Gs5ZjgQAc+sf3G41ec8ypSDFdGJaT0+lZdHwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519800323; bh=u
    kst9oGZhzA6b9Qs71BXH4EsLctsKIvxRzv7lifUa6Y=; b=LN4UadbeiID1b8Q4a
    E38w+lK36+jac8R8aAKxCSga7Mwv60KASM+taEcocm+kBCmoLNP56f2oUmxg7t8D
    LgbQFwuIBLVlKe0+vCSUbQ0Oa0USQpp9bjy06LlzQO75FML5um1hOrhH1wFKVlRO
    sT7Db5RnYXg1iA+ePQZXw+RfWwz4MjYsapEIimpEGkem0txahWT0E3w6TmhlnLVe
    6nsclGuJLNKM22bPFbiKHAHh1tsD9IV5R+tvHJAz2WiMV2qYmeMq4rzmffk3PqTx
    gRNph7dVfZbLbDLtNCkfGIES5PUc2e+woxSc9ZOU5+TyX+vRlLmyIXJgbQ8e+wIl
    1t5Aw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=U2T3Iy9k x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=U2T3Iy9k x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Wed, 28 Feb 2018 09:40:05 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Ivan Safonov <insafonov@gmail.com>
Subject: Re: [PATCH] staging:r8188eu: use lib80211 CCMP decrypt
Message-ID: <20180228064005.k3fxcenjestzdrds@mwanda>
References: <20180223145742.25783-1-insafonov@gmail.com>
 <20180226075625.kcksm35y4clqvi5l@mwanda>
 <f1c692e8-7d51-4be1-6db5-8067ff8d0151@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f1c692e8-7d51-4be1-6db5-8067ff8d0151@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8817
 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=384
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802280079
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
 Janani Sankara Babu <jananis37@gmail.com>, linux-kernel@vger.kernel.org,
 Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hm...  Sorry.  I was looking at the wrong code.

I was looking at aes_decipher() instead of rtw_aes_decrypt().  The
aes_decipher() was acceptable style (although, it's of course good that
you deleted it).  rtw_aes_decrypt() was always really really awful.

That's fine then.  Sorry again.

regards,
dan carpenter

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
