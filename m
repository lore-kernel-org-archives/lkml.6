Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-703119-1520227128-2-15629510515316463400
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520227127; b=Fm7DHDd8bY8BB7xfKVc20jIagd4pcvxfiMqmGDtjA8v2/qc
    u5ErsqPEkAZlGd/SioYjw948yafGSwOEMU9hNpNQVgfKTJfAvnCbukRqTTrov9vE
    aB5WbMp9NQANiM1faMsLRfZZSkRAhhxAUnvHDHDxwkagTOU6VFNgKNAXV11wuhsx
    JpODq3og/bLE9D57ijdYi3HntlGaQUF6GqJ8ftvy6v/v3pMHiq1kYgfbq96vhzYD
    VmxeCDWGxJSssRtbIiApQ+4nWbeflzjW1CQMe77lBoJr3h/SoMVcT68fHHwlkAyC
    cv8qW6RhjxxCdH4vBohzLwVkUewE5Joiaw5dKLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:reply-to:cc:mime-version
    :content-type:content-transfer-encoding:sender; s=arctest; t=
    1520227127; bh=imFWyhAln+ti0S0va9OH8uJp5NBKFngIxq/bjw3OH9w=; b=W
    eoFYtZHT1zy2nW7l1hgdmDhO/hhgO8NLQHGdt8Oayx1Hj0+WCgCoCUCIvFnGIoio
    FMBpyLROueCIRomIyd4rSCqJt6VaXXIbQM2CFsXP8CEqGyF7iHL89eLuZ72S/5Z+
    xULtun1pHdCfEUKbZv6lJtA3WI9zw8UaEhdqgQu6JnSUz6iaYG8jzq5YlxuWj41r
    fmT0kjO84EBx0NACmsXc9C/4HF40Ep0fzg2mQ8EoVZNXZZh00sM64qKGzULaBjAH
    RkgEjqlC22VF5IK+UavSmizykbV7HCvst6FTCoM/mHPURd6rFpzRext/tlvYqLXc
    Wjbe/nB/YOnrAHBlrec5Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=exchange.microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=exchange.microsoft.com header.result=pass header_org.domain=microsoft.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=exchange.microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=exchange.microsoft.com header.result=pass header_org.domain=microsoft.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
x-originating-ip: 107.180.71.197
From: kys@exchange.microsoft.com
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
 vkuznets@redhat.com, jasowang@redhat.com, leann.ogasawara@canonical.com,
 marcelo.cerri@canonical.com, sthemmin@microsoft.com
Subject: [PATCH V2 01/12] tools/hv: Fix IP reporting by KVP daemon with SRIOV
Date: Sun,  4 Mar 2018 22:17:11 -0700
Message-Id: <20180305051722.19157-1-kys@exchange.microsoft.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180305051539.19079-1-kys@exchange.microsoft.com>
References: <20180305051539.19079-1-kys@exchange.microsoft.com>
X-CMAE-Envelope: MS4wfDch5AamIWLDIzqOgePNspxa5B1ze5PJbibwdrjSc3LyMWF2ZybMGi3dCzZ7J9zAtyWmyyIv1rKPJeoCszvBXIOdDLmw2oDbzJk/pVfza0ouxX4xKr/X
 X3knNurBSkIIxrmCdv3vUaGKcyJRdmxV0CoHNTxov+rAIi8S4a5NsDlp+adK1dUvCK5R4cB7H9FnGHPPgA0e9wGwdwY/4XxrCcqMf6oKOO7SKrQoBfivCC0K
 rBDWgt5Wvz1nuJ6O7GCrYsyuj9kQVebkCiB5lGYel/vvh3tJto6qJc5nLY/7Ymqf+lakPhrC+p74znwa8uRJywQkj88+v4tp4Bmc8l98dqADmZ+dFJ5jQJuq
 MEbb6Qxh7qC1uwkNnL37RhRHeAFuwFz3Mhvt1Gg1TNdaNyE9/kiTDv8nNe3iP6aWIcsL6Iqvb8bkfQX+QnQ54Wb8sk9fwnubFT6jrGNBoi1hf5Y8gZNx5MxX
 H7t8/gExlXC/VzwXFqg9uAY1jduLDde6B1sjmECskw+eMkWp0NXM8cFYsfEsZ+VsF2i7XeORTI7zhsbpprUsEcOwRxJn4gr0ZFUXV/we4/61fUSZ3Cw17tvX
 GT9LcHNqFGET7gvdat42EYJz
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
Reply-To: kys@microsoft.com
Cc: Haiyang Zhang <haiyangz@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Haiyang Zhang <haiyangz@microsoft.com>

On Hyper-V the VF NIC has the same MAC as the related synthetic NIC.
VF NIC can work under the synthetic NIC transparently, without its
own IP address. The existing KVP daemon only gets IP from the first
NIC matching a MAC address, and may not be able to find the IP in
this case.

This patch fixes the problem by searching the NIC matching the MAC,
and having an IP address. So, the IP address will be found and
reported to the host successfully.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 tools/hv/hv_kvp_daemon.c | 138 ++++++++++++++++++++++-------------------------
 1 file changed, 65 insertions(+), 73 deletions(-)

diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
index 4c99c57736ce..dbf6e8bd98ba 100644
--- a/tools/hv/hv_kvp_daemon.c
+++ b/tools/hv/hv_kvp_daemon.c
@@ -634,64 +634,6 @@ static char *kvp_if_name_to_mac(char *if_name)
 	return mac_addr;
 }
 
-
-/*
- * Retrieve the interface name given tha MAC address.
- */
-
-static char *kvp_mac_to_if_name(char *mac)
-{
-	DIR *dir;
-	struct dirent *entry;
-	FILE    *file;
-	char    *p, *x;
-	char    *if_name = NULL;
-	char    buf[256];
-	char dev_id[PATH_MAX];
-	unsigned int i;
-
-	dir = opendir(KVP_NET_DIR);
-	if (dir == NULL)
-		return NULL;
-
-	while ((entry = readdir(dir)) != NULL) {
-		/*
-		 * Set the state for the next pass.
-		 */
-		snprintf(dev_id, sizeof(dev_id), "%s%s/address", KVP_NET_DIR,
-			 entry->d_name);
-
-		file = fopen(dev_id, "r");
-		if (file == NULL)
-			continue;
-
-		p = fgets(buf, sizeof(buf), file);
-		if (p) {
-			x = strchr(p, '\n');
-			if (x)
-				*x = '\0';
-
-			for (i = 0; i < strlen(p); i++)
-				p[i] = toupper(p[i]);
-
-			if (!strcmp(p, mac)) {
-				/*
-				 * Found the MAC match; return the interface
-				 * name. The caller will free the memory.
-				 */
-				if_name = strdup(entry->d_name);
-				fclose(file);
-				break;
-			}
-		}
-		fclose(file);
-	}
-
-	closedir(dir);
-	return if_name;
-}
-
-
 static void kvp_process_ipconfig_file(char *cmd,
 					char *config_buf, unsigned int len,
 					int element_size, int offset)
@@ -997,6 +939,70 @@ kvp_get_ip_info(int family, char *if_name, int op,
 	return error;
 }
 
+/*
+ * Retrieve the IP given the MAC address.
+ */
+static int kvp_mac_to_ip(struct hv_kvp_ipaddr_value *kvp_ip_val)
+{
+	char *mac = (char *)kvp_ip_val->adapter_id;
+	DIR *dir;
+	struct dirent *entry;
+	FILE    *file;
+	char    *p, *x;
+	char    *if_name = NULL;
+	char    buf[256];
+	char dev_id[PATH_MAX];
+	unsigned int i;
+	int error = HV_E_FAIL;
+
+	dir = opendir(KVP_NET_DIR);
+	if (dir == NULL)
+		return HV_E_FAIL;
+
+	while ((entry = readdir(dir)) != NULL) {
+		/*
+		 * Set the state for the next pass.
+		 */
+		snprintf(dev_id, sizeof(dev_id), "%s%s/address", KVP_NET_DIR,
+			 entry->d_name);
+
+		file = fopen(dev_id, "r");
+		if (file == NULL)
+			continue;
+
+		p = fgets(buf, sizeof(buf), file);
+		fclose(file);
+		if (!p)
+			continue;
+
+		x = strchr(p, '\n');
+		if (x)
+			*x = '\0';
+
+		for (i = 0; i < strlen(p); i++)
+			p[i] = toupper(p[i]);
+
+		if (strcmp(p, mac))
+			continue;
+
+		/*
+		 * Found the MAC match.
+		 * A NIC (e.g. VF) matching the MAC, but without IP, is skipped.
+		 */
+		if_name = entry->d_name;
+		if (!if_name)
+			continue;
+
+		error = kvp_get_ip_info(0, if_name, KVP_OP_GET_IP_INFO,
+					kvp_ip_val, MAX_IP_ADDR_SIZE * 2);
+
+		if (!error && strlen((char *)kvp_ip_val->ip_addr))
+			break;
+	}
+
+	closedir(dir);
+	return error;
+}
 
 static int expand_ipv6(char *addr, int type)
 {
@@ -1472,26 +1478,12 @@ int main(int argc, char *argv[])
 		switch (op) {
 		case KVP_OP_GET_IP_INFO:
 			kvp_ip_val = &hv_msg->body.kvp_ip_val;
-			if_name =
-			kvp_mac_to_if_name((char *)kvp_ip_val->adapter_id);
 
-			if (if_name == NULL) {
-				/*
-				 * We could not map the mac address to an
-				 * interface name; return error.
-				 */
-				hv_msg->error = HV_E_FAIL;
-				break;
-			}
-			error = kvp_get_ip_info(
-						0, if_name, KVP_OP_GET_IP_INFO,
-						kvp_ip_val,
-						(MAX_IP_ADDR_SIZE * 2));
+			error =  kvp_mac_to_ip(kvp_ip_val);
 
 			if (error)
 				hv_msg->error = error;
 
-			free(if_name);
 			break;
 
 		case KVP_OP_SET_IP_INFO:
-- 
2.15.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
