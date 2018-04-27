Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrsHgtfkHqPvmTEODa0JdQsyQ5EeZnTZHtmSXWOlY50E03tBdKnOBa31arP5uHVHydhC9zs
ARC-Seal: i=1; a=rsa-sha256; t=1524837705; cv=none;
        d=google.com; s=arc-20160816;
        b=cbuCuIaV0xNYdrSTsAN/S4RUtzgW3MeEmIFNn6FKVDgdrSNeaMBe6NtRi+PZSq37EJ
         qJlkZFk9i4k1q0B57Qpnr1WuEkbzq7njRkO3Aq2CGWHytbu1dfIfxzVUZILCjXzTpm+Z
         k3b+gkW+7IzoceMqTPk7ZUFPk9CJYtZDbE05op0svWRFHjgIqB98wCnFSsax4BD+geqW
         tAzc3GY4ugqyvbvB8aBiwG9/2Wp/LHyeB2u1yIZvSD6i1zy7JidYFdq/K9dqBBQtuFU2
         2cBixUOynI6jY85KfOBSaJW0Ecz2x+m9Snx5FMnXUuuj2d1kHE3BNFeM19yl+2PCk6PL
         flng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=ZqtoS5ByaEFCrwmCbbNuaETKZqejS12BXH1/vAhnMQU=;
        b=lWdJFwioD5SHeN+Dygr/b4bOLln+h33VisEt3bRO4G7URlvkvg3u39QgC/I7NQmyGF
         9UDEWodV5KZWtcMGKV5Nzr/cyYFh/9YhfPKsnhljYmaLKvbmYKrPlqwW6VZ3vYPEwgDj
         gvV7hKgct9G463euk/25Qs99Lhi4PwUML8WXcDcieIzFq4Bv+fUZ9wS8tP9uxKcatvhY
         cKGYQ4tyqqdq0/hDpBB2jigb3vEhCdpcX9UmrkewgUE3TiEQB39ZapPQwrlcNYT9GqbL
         +6/fpSWGE7eIXb7vj6Jtl8UW1XKQRbrQ87HHZKdIXfWJFLJzVOS2p08v+nOjjFJAor6t
         5Y5Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 921252185A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Jo=C3=A3o=20Avelino=20Bellomo=20Filho?= <jbellomo@redhat.com>,
	Xin Long <lucien.xin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 35/50] team: fix netconsole setup over team
Date: Fri, 27 Apr 2018 15:58:37 +0200
Message-Id: <20180427135657.753338237@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135655.623669681@linuxfoundation.org>
References: <20180427135655.623669681@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908221945898093?=
X-GMAIL-MSGID: =?utf-8?q?1598908221945898093?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>


[ Upstream commit 9cf2f437ca5b39828984064fad213e68fc17ef11 ]

The same fix in Commit dbe173079ab5 ("bridge: fix netconsole
setup over bridge") is also needed for team driver.

While at it, remove the unnecessary parameter *team from
team_port_enable_netpoll().

v1->v2:
  - fix it in a better way, as does bridge.

Fixes: 0fb52a27a04a ("team: cleanup netpoll clode")
Reported-by: João Avelino Bellomo Filho <jbellomo@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/team/team.c |   19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -1050,14 +1050,11 @@ static void team_port_leave(struct team
 }
 
 #ifdef CONFIG_NET_POLL_CONTROLLER
-static int team_port_enable_netpoll(struct team *team, struct team_port *port)
+static int __team_port_enable_netpoll(struct team_port *port)
 {
 	struct netpoll *np;
 	int err;
 
-	if (!team->dev->npinfo)
-		return 0;
-
 	np = kzalloc(sizeof(*np), GFP_KERNEL);
 	if (!np)
 		return -ENOMEM;
@@ -1071,6 +1068,14 @@ static int team_port_enable_netpoll(stru
 	return err;
 }
 
+static int team_port_enable_netpoll(struct team_port *port)
+{
+	if (!port->team->dev->npinfo)
+		return 0;
+
+	return __team_port_enable_netpoll(port);
+}
+
 static void team_port_disable_netpoll(struct team_port *port)
 {
 	struct netpoll *np = port->np;
@@ -1085,7 +1090,7 @@ static void team_port_disable_netpoll(st
 	kfree(np);
 }
 #else
-static int team_port_enable_netpoll(struct team *team, struct team_port *port)
+static int team_port_enable_netpoll(struct team_port *port)
 {
 	return 0;
 }
@@ -1192,7 +1197,7 @@ static int team_port_add(struct team *te
 		goto err_vids_add;
 	}
 
-	err = team_port_enable_netpoll(team, port);
+	err = team_port_enable_netpoll(port);
 	if (err) {
 		netdev_err(dev, "Failed to enable netpoll on device %s\n",
 			   portname);
@@ -1900,7 +1905,7 @@ static int team_netpoll_setup(struct net
 
 	mutex_lock(&team->lock);
 	list_for_each_entry(port, &team->port_list, list) {
-		err = team_port_enable_netpoll(team, port);
+		err = __team_port_enable_netpoll(port);
 		if (err) {
 			__team_netpoll_cleanup(team);
 			break;
