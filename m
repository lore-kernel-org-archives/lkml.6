Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4022440-1526045959-5-3705805081228914491
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526045958; b=dAmyQeuB0NqkVz0fTjPj05dwJ40dtHTegNnuwg1lolWfLUc8Ip
    nLtqjAMcKtW5CBQ8upye2qxMEbJSDqRO3L/aB8EoyI0Wr/0nGTql/sPVbRd+6FEy
    ag6/LCp/QaAfmWqkIjlGy/GZr+Wrk0mKn3d/CnM+e/b7Bh2VbsHXE6HzhWGmbIah
    f017NtxcFY02PmNR8Batm+Of84aHbHhUcKJrjSjlPeYwLljnh67mjB/ykvfmWeQB
    QH8TI2krskLt7IdUfQ/5U4Q9xCbWbpF3DqUC0rFeF72ammR7j4pCny5Q+aorvlqB
    CYCzKW4DcyxCQ0Beks7kJnghwt63QwRcmzEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526045958; bh=4iIcf
    GyGESxUUHZCSwB2oPRbFBUn37KCiPOm+WbEwb8=; b=iGTaZs6PA2rPQkZWgW834
    wtXuyPN3vsvEqVRSONPb+vKIiq6vBx7fpyyu5LHMyb7hd++rktCkolRfbaQs7iJQ
    IQZEPwYLyMYMIWnuyWDQsNt//cjW9n0v5rbusvZ83ejZHFpPHRMul/dGfPN1mDct
    yC4tgVAY6ylOuyHWrRRx5JEjijD29uLAUJo1C5Fv6hGfqTOYTpx2aWaY6WZ+bhPt
    NYUcLOHLlskqvjr0crl/SGK/HAc/sRyym3xssuM/IzKBdT2d1sjpMWlCLOrOqvTM
    DtJ/FS/zoB72InAoANmwv3CpmiQ3PAnE5wnGtpvOFjSFwyHr9NXpWKtVrcNx4/4O
    A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=canonical.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=canonical.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCHoBBi9Vt9/YmL6Jbfz5OY6EoC6VPnPyE2Jc6lcPO+JE0mtHLJaYedNc8BftIAqMpLphGfBXzpwun0lYCrCyt9BWxs2KEmbXFFBjhgo7MS5Rh/gY3Ds
    j0uvZnuOZx2XQCr4bMxjGh2TpPYu4SJd0gSbGknYy0Ws4t5FduPXz7rIhI/N5kxmbphlhPQzdDtdxgE8MoOQDQb2xPoQJ3VNzHXeAaBTDQSrOxLEKAsTzrNb
    wo0+7CMFyhYLNBel4lvOPA==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DfNHnWVPAAAA:8 a=DDOyTI_5AAAA:8
    a=3zzOoi70IWB4A3Ng1bQA:9 a=CjuIK1q_8ugA:10 a=rjTVMONInIDnV1a_A2c_:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Colin King <colin.king@canonical.com>
To: Oleg Drokin <oleg.drokin@intel.com>,
 Andreas Dilger <andreas.dilger@intel.com>,
 James Simmons <jsimmons@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 NeilBrown <neilb@suse.com>, lustre-devel@lists.lustre.org,
 devel@driverdev.osuosl.org
Subject: [PATCH] staging: lustre: fix spelling mistake: "req_ulinked" ->
 "req_unlinked"
Date: Fri, 11 May 2018 14:38:59 +0100
Message-Id: <20180511133859.18733-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
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
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in DEBUG_REQ message text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Andreas Dilger <andreas.dilger@intel.com>
---
 drivers/staging/lustre/lustre/ptlrpc/client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/lustre/lustre/ptlrpc/client.c b/drivers/staging/lustre/lustre/ptlrpc/client.c
index eeb281266413..a51feaeb7734 100644
--- a/drivers/staging/lustre/lustre/ptlrpc/client.c
+++ b/drivers/staging/lustre/lustre/ptlrpc/client.c
@@ -2514,7 +2514,7 @@ static int ptlrpc_unregister_reply(struct ptlrpc_request *request, int async)
 		}
 
 		DEBUG_REQ(D_WARNING, request,
-			  "Unexpectedly long timeout receiving_reply=%d req_ulinked=%d reply_unlinked=%d",
+			  "Unexpectedly long timeout receiving_reply=%d req_unlinked=%d reply_unlinked=%d",
 			  request->rq_receiving_reply,
 			  request->rq_req_unlinked,
 			  request->rq_reply_unlinked);
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
