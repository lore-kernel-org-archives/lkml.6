Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx499vUY8RoQyTlI8QWO7JWB3qf/jZNWefhv03hKePeSxs+/oKuPdMt7twBoGPMR4J6HLMvBM
ARC-Seal: i=1; a=rsa-sha256; t=1523473258; cv=none;
        d=google.com; s=arc-20160816;
        b=tTEc5D9/1bVGid4EBPE+SfmP6h2wMfoUzTNfNMTV6m3oxlyqlggXsDWcZakwL6IX+d
         q386V4xmst+r7pJANCnSBspRX2bdz8V/hM9fc2fkcqJ9bEX6CdSSzsB2xG6Z0aQ7zPpd
         1H0+lUathZSBomQ8epkHl+PkdT+ZaGqBjlzLotRUpK2hng+XnNTlSaNpvuCLJsuhaIsv
         CrBTFITCtonREK6Sgzb8ur0AUm5Kv5MyO3GhVCalQ8A002gWSuQRlyk5JRUg76YtVL1n
         ldPNkGqpytepbH1CYgzE2YGL4yZletHM0VwJl5I8Gc2/39b46WwFmqZ4Iqfx24aEmYx8
         xPXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=GSaosoGu99CqV6Jf7pCNxdVZM6ivlfJu2dZ1TFUMCnU=;
        b=tw9jRjtKXhDI6XJRsygfzV8xrlfx155eRH4HGEAtC4vuNcoBufFVUSO/BUP6xRoGWG
         YwXDoCz8PH8TOWl7aqMGqPX4zYSKdLg8kPgVTEewWvFneL1VOhZeoXl9YjWKWfYAqehZ
         ftVhnP9X8cgKVpKMRhVJO+X8sj/8oY+kJHVtszkE2beCPOBJIVP2b0U17ieTYIEFuYgf
         mI5Rgrmc+O4j12S2MhKanLq6Rkj7VVN9j2PPCK9xbmaDknZdyRE7fjkWkpWUEW99ncY8
         R/jsgoINBAt38/dZ2u1lk78VoRhV/E9jyV3MSv28GJWg6CYz35cGSoSOeBBzHDIUTo9n
         3B8A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Steven L Roberts <robers97@gmail.com>,
	Leon Romanovsky <leon@kernel.org>,
	Dennis Dalessandro <dennis.dalessandro@intel.com>,
	Doug Ledford <dledford@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 183/310] RDMA/hfi1: fix array termination by appending NULL to attr array
Date: Wed, 11 Apr 2018 20:35:22 +0200
Message-Id: <20180411183630.474967314@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477495722929104?=
X-GMAIL-MSGID: =?utf-8?q?1597477495722929104?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Steven L. Roberts" <robers97@gmail.com>


[ Upstream commit c4dd4b69f55abcc8dd079f8de55d9d8c2ddbefce ]

This fixes a kernel panic when loading the hfi driver as a dynamic module.

Signed-off-by: Steven L Roberts <robers97@gmail.com>
Reviewed-by: Leon Romanovsky <leon@kernel.org>
Acked-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/hfi1/sysfs.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/infiniband/hw/hfi1/sysfs.c
+++ b/drivers/infiniband/hw/hfi1/sysfs.c
@@ -196,7 +196,8 @@ static const struct sysfs_ops port_cc_sy
 };
 
 static struct attribute *port_cc_default_attributes[] = {
-	&cc_prescan_attr.attr
+	&cc_prescan_attr.attr,
+	NULL
 };
 
 static struct kobj_type port_cc_ktype = {
