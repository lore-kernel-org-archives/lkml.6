Return-Path: <kernel-hardening-return-12476-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsSjDRP9SuTIfwqtpqqgaS8IKEWY6PJ5oRFFkN0VC+kHj+MdpPr2F531Aubv1K4U4YpuP1D
ARC-Seal: i=1; a=rsa-sha256; t=1520881718; cv=none;
        d=google.com; s=arc-20160816;
        b=XaAfhR6890nsr7i5vbA4J/MaPUIumk7qHvkT32gEmktHWFqYC5rHH850pFKdk2Qu53
         m8yszT2JbHbIlsJiw/yDNHLB29JiMHuBlGPd+yvNrTG++FApc05TUjiGPnNS6M1eDqGu
         4nH2FwjjOYPt0jzbMCvGvhK+jm6zWVzfDxwEe6KGecKzEX+BNsYOCeMKZlSDp3fZ98vj
         S3ijH6LhsIL8dPUSLHuc8E5PWyYNoCpY6EZ4RLn6Bv/BtivfPpOV71WNTUJo7eLJW9qZ
         Eymw18CB7zC2hxnPY3VlSuHF1CNsrlH41D+ehVTiR4x2/1yCwcl4Ub+myM6N/C3JuLSl
         0KeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=ydByLj9tVAXESVQ4HnhE0j6BLeCBpDb9dhX/bKsKzfE=;
        b=QQUgYOljv3EfWB7lQ1Ksu1NjV8HweVedixJD16gLIWC+qW5mkaoWQ/KlRQM5GtGRZ9
         huqK01honmNP/1qGo9/5HN7ip2gmJSY6Dkkl9xy8o34m4PPXb3o+7xullOEy/vsQTgRD
         PTQLrzIrpbFRQqN0+eSg4I4hEuuWJ/NpptlOkAfKg3H4LAtnUOQxx49sa6xCSup7AECo
         LBdaBoC3Hgw2NOgl09KgKzHfIMOmhfW6/IilFBCYLHLOt3BPJ74+3rDoTQsu8VSU/tf5
         zWtq+qxtT9R0LF4tvbQkJvhnA8GJC/haQBg5eEPG8CY4DAU6S/YbGGYLdVuvzXln/8JD
         dO1g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12476-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12476-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12476-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12476-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Mon, 12 Mar 2018 15:08:15 -0400 (EDT)
Message-Id: <20180312.150815.1091524401090660262.davem@davemloft.net>
To: s.mesoraca16@gmail.com
Cc: linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org, keescook@chromium.org,
 santosh.shilimkar@oracle.com
Subject: Re: [PATCH 2/2] net: rds: drop VLA in rds_walk_conn_path_info()
From: David Miller <davem@davemloft.net>
In-Reply-To: <1520802470-17374-2-git-send-email-s.mesoraca16@gmail.com>
References: <1520802470-17374-1-git-send-email-s.mesoraca16@gmail.com>
	<1520802470-17374-2-git-send-email-s.mesoraca16@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594677132836039871?=
X-GMAIL-MSGID: =?utf-8?q?1594760068149840195?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Salvatore Mesoraca <s.mesoraca16@gmail.com>
Date: Sun, 11 Mar 2018 22:07:50 +0100

> Avoid VLA[1] by using an already allocated buffer passed
> by the caller.
> 
> [1] https://lkml.org/lkml/2018/3/7/621
> 
> Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>

Also applied, thanks.
