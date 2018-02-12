Return-Path: <kys@linuxonhyperv2.linuxonhyperv.com>
X-Google-Smtp-Source: AH8x2243cyp73GKMb2bw4rKRcwiova3v6SGjWOzQm4CzTAiwmHFI9snHv+ZpnAgESLFd3E4E+A3H
ARC-Seal: i=1; a=rsa-sha256; t=1518395677; cv=none;
        d=google.com; s=arc-20160816;
        b=1IzEWAul8FQ6oDbhMb/FGR61iIx5I3EDodjvqrIEzrglLvRhUcNMtI5D87XCkojZD9
         qFzZdGa8DYaDMBPOTwix9r6Y189KCdePdjA4otUb2cg5LlawBBqOEIUEcgGuRs+kaveh
         ckx7izU0c4F6TRu54n/S4fO8p+xWZ4+Hv5WVr1MHXPKCMMea6BfPLiU/YEGsjvdsLzpA
         NWKJ0cmodJY1rewQK+HoAIi1cT7GpcP44E+6iCxLnxa+gPeh00InW1eUt/+7amQ0nzzJ
         TFf/bkupm3dnfux26y7WP6zHwM1bHL4gm5umK07vD9PHR9oHLJeEj+n2SHwWFHhEwr5E
         JEaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=reply-to:references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=R3kHaS3UHzeaKjpV5WqNVUXxku0yrrCv8xbl67XnXSc=;
        b=flOgrfrzog42AFCrGlzq7lVWDw86OHeejNyoNXjuRxkE2Y71jzPVK8aNBwrU3gq5mf
         +gRFMxgTlz5mDCcjbqTXwIL+YkYc1UvU8NCuzFt4sTH4KFoJtPLIiUfh63iE8oqEc9so
         O96xPhZbtHOfdGYkSWlbru18js0PheI1hKqMTMoeQ0OvCmTz7Q71xx8ld8TeL5T1HMHj
         VW90HEh4748hXaZY1fjkycjFZ05gNQ+LGfHLqWVJtEsi3cP3UR6/hI7qhl/xQ5ECKA4J
         BwwzR9JXswDgQVqf+BuwdyDVC6+wHq8gqpsDSKfxb47vEFZytfANO1AI1npDGkj6D7IS
         ulpg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 198.71.225.38 is neither permitted nor denied by best guess record for domain of kys@linuxonhyperv2.linuxonhyperv.com) smtp.mailfrom=kys@linuxonhyperv2.linuxonhyperv.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=exchange.microsoft.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 198.71.225.38 is neither permitted nor denied by best guess record for domain of kys@linuxonhyperv2.linuxonhyperv.com) smtp.mailfrom=kys@linuxonhyperv2.linuxonhyperv.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=exchange.microsoft.com
x-originating-ip: 107.180.71.197
From: kys@exchange.microsoft.com
To: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	devel@linuxdriverproject.org,
	olaf@aepfle.de,
	apw@canonical.com,
	vkuznets@redhat.com,
	jasowang@redhat.com,
	leann.ogasawara@canonical.com,
	marcelo.cerri@canonical.com,
	sthemmin@microsoft.com
Cc: Haiyang Zhang <haiyangz@microsoft.com>,
	"K . Y . Srinivasan" <kys@microsoft.com>
Subject: [PATCH 01/12] tools/hv: Fix IP reporting by KVP daemon with SRIOV
Date: Sun, 11 Feb 2018 17:33:09 -0700
Message-Id: <20180212003320.6748-1-kys@exchange.microsoft.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180212002958.6679-1-kys@exchange.microsoft.com>
References: <20180212002958.6679-1-kys@exchange.microsoft.com>
Reply-To: kys@microsoft.com
X-CMAE-Envelope: MS4wfHWyA3bWQpJbWP7paxsWZ4WiegLdr/MCrqMhpnf7IdDAdEuAh6/GiOfoWsqrWthZGN1Q6iHsE4nVKVe2t61vUyTUCdWp7KO9aUtm4q3xEZB1IdJQoC0D
 2oTVvnveXmhDvGMxe6D6fuzerbUchQHVpcunCNRdpeZyU4xBkwQ1/yGrHDoxlbuyOEwsTyIIYJRCUqOttaL5irOuowXp3w5eJi1t6VJgGwDat1KRPp2wXSOj
 He5Y63QB9a6Pr8lR3Sy/i9cJqUdSYbR81pLpAN2y2zVZMM83tQU1cbU5janAwD+DRFCx16lT6VI/dZE1mnvZ7PvDuW/EmtXy9Gfo1zY6pfPZcG+rRlL/tb6Y
 /bgkUkTP1iwxzxSqzx2ToE17S9yjmMy73cky3eFQZhM8kI3pNf6dFRPfSjNKmmrTz0varQUIXWUkDbyBUOh/3W4uzlqsO/cQItLP7oA/92mQ9LhfOG54jW/p
 FhrIfPDKsVjddr/rlVgx3YfYyFzcMuv9+zaTnIFWvFdWcr2NmfJOBG5+5ZFmNiJS8tpvTVYTPZDt0CR6IZLB99ii4WToQFZWB7ClhSVBJv8pHU1co1zntTw2
 dW881tHKiPOqxGT4Q1D+i4uF
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592153265311281374?=
X-GMAIL-MSGID: =?utf-8?q?1592153265311281374?=
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
