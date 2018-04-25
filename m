Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+7pZQ7G6Pn8q5VTcMqAFkqBcPNftSWXr2m3aDPcuxGiiENHheJdiYL9ZXosJjQJztnMMQJ
ARC-Seal: i=1; a=rsa-sha256; t=1524653018; cv=none;
        d=google.com; s=arc-20160816;
        b=AFx1TEV3/acijnggVppYLIMxB5yrwj2vhUVl6y88FZtv9DAmPQarMqfi/FIy7gxMVg
         uu7AAWSJBeBy6gvPXB5Wr0KebKU3ogvw+Q/RBtClkb7YRELN6D4NTpNnzeCEVNBqBhB4
         mxDpQYHnKjwrA9cTi+RR1vE8ShTNBu/jSJI4ehR5JhKXYWZkULUfRyRWec4NUx0oVTog
         f4AqAkvvMO3QEYnJRKXvF0CyClF+bLnxU+th3I74Q9/qweLtSD25GLC/WR03HKjVvo7Y
         UCGEOXJUaiS3yQj4XhzIAiyUby3aSNw0yUChHBP2HLaIOqdUUawm2P7BM4lbCVvhqTha
         EpQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=SHu+a1O04LHkVjhXegVyJJMt8BVwVexmYCYV3W2x564=;
        b=Gs4SnwC0zRcEW56uT/w1kvLqns+Sk1CHg5R0u47HwEHDm9A2mtR5Vu5WjMemqepd1c
         pww0D/8o98BUYuOyrJWiPl0W1RpvTp2gJ0fhIOxlA//T7Pz/emOuhNwetJeLWtFlRST4
         0tU3xXgt0TIFdfPyL7ZZT5HnH0zcvN9hoeLjNKjdZqD7dc6Xm6x+ol5uE+GKVlcRYceO
         BGd6mDnADNQl5YSstVGfF8SEfJpcCLVR/1Sv1lMLpL39McSw3WsOmhPAt7d9zMZZRppK
         ndWnHk8oJK5TFEd1DLt6cjNYEazSCOEIM30GqAdHCdhO2I2NS42D4Uz9G7tlplIWrp/J
         gPhw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mathieu Malaterre <malat@debian.org>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 155/183] net: Extra _get in declaration of arch_get_platform_mac_address
Date: Wed, 25 Apr 2018 12:36:15 +0200
Message-Id: <20180425103248.771916977@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714563356981057?=
X-GMAIL-MSGID: =?utf-8?q?1598714563356981057?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mathieu Malaterre <malat@debian.org>


[ Upstream commit e728789c52afccc1275cba1dd812f03abe16ea3c ]

In commit c7f5d105495a ("net: Add eth_platform_get_mac_address() helper."),
two declarations were added:

  int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr);
  unsigned char *arch_get_platform_get_mac_address(void);

An extra '_get' was introduced in arch_get_platform_get_mac_address, remove
it. Fix compile warning using W=1:

  CC      net/ethernet/eth.o
net/ethernet/eth.c:523:24: warning: no previous prototype for ‘arch_get_platform_mac_address’ [-Wmissing-prototypes]
 unsigned char * __weak arch_get_platform_mac_address(void)
                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  AR      net/ethernet/built-in.o

Signed-off-by: Mathieu Malaterre <malat@debian.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/etherdevice.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/etherdevice.h
+++ b/include/linux/etherdevice.h
@@ -31,7 +31,7 @@
 #ifdef __KERNEL__
 struct device;
 int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr);
-unsigned char *arch_get_platform_get_mac_address(void);
+unsigned char *arch_get_platform_mac_address(void);
 u32 eth_get_headlen(void *data, unsigned int max_len);
 __be16 eth_type_trans(struct sk_buff *skb, struct net_device *dev);
 extern const struct header_ops eth_header_ops;
