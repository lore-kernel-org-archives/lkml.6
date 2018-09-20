Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA43C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 09:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B3DB20880
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 09:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I3VCzpcm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B3DB20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731709AbeITO7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 10:59:18 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60766 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731343AbeITO7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 10:59:17 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8K9Dgr8011685;
        Thu, 20 Sep 2018 09:16:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2018-07-02; bh=jv2N+nPizbsJlH7YKwIQJ6fC1R4QnjCngwNx9fYE0vo=;
 b=I3VCzpcmUz8KyoRWCNL/2OTaZplRJ/QtKFMCLZ2/qvrhQTfbomcGnIdVJiFTqBdlbYEz
 P4eiQUsoRZvF3wiPKxqdWDSAIEthjf6jJ0oOOU3ca3N4itGab5NyK01G42Ifl+rQaOgC
 3wQlue2SWt2twCr+5PPHd+R48LeYYa5vjbxtT2N/8bT7D5271rC9yJ+3vhygfge1VOhk
 F4sEZ/kjchkBZKLLI+ZTFJpDK0tHb6IA4zApe2Ay33GL0eLYsq/Y1hai8IqK1+nIb2uO
 aCFB6A+va8PdtWIjS2hvfdjdIOvTLi67Wfi3JU92m92ySE0x3pRbm2eFqg7fXwtG9U2Y mQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2mgtqr9fq0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Sep 2018 09:16:41 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8K9GeXt010174
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Sep 2018 09:16:41 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8K9GdMP012049;
        Thu, 20 Sep 2018 09:16:39 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 Sep 2018 02:16:38 -0700
Date:   Thu, 20 Sep 2018 12:16:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@01.org, Lyude Paul <lyude@redhat.com>
Cc:     kbuild-all@01.org, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Sean Paul <sean@poorly.run>
Subject: Re: [PATCH 1/6] drm/dp_mst: Introduce
 drm_dp_mst_connector_atomic_check()
Message-ID: <20180920091631.dyxytd7zecbpmv64@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918230637.20700-2-lyude@redhat.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9021 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809200095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lyude,

Thank you for the patch! Perhaps something to improve:

url:    https://github.com/0day-ci/linux/commits/Lyude-Paul/Fix-legacy-DPMS-changes-with-MST/20180919-203434
base:   git://anongit.freedesktop.org/drm-intel for-linux-next

smatch warnings:
drivers/gpu/drm/drm_dp_mst_topology.c:3144 drm_dp_mst_connector_still_exists() error: we previously assumed 'port' could be null (see line 3146)

# https://github.com/0day-ci/linux/commit/f8df31d5221b9a6da6698d4a37e622253bb17cdc
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout f8df31d5221b9a6da6698d4a37e622253bb17cdc
vim +/port +3144 drivers/gpu/drm/drm_dp_mst_topology.c

3f3353b7 Pandiyan, Dhinakaran 2017-04-20  3131  
f8df31d5 Lyude Paul           2018-09-18  3132  static bool
f8df31d5 Lyude Paul           2018-09-18  3133  drm_dp_mst_connector_still_exists(struct drm_connector *connector,
f8df31d5 Lyude Paul           2018-09-18  3134  				  struct drm_dp_mst_topology_mgr *mgr,
f8df31d5 Lyude Paul           2018-09-18  3135  				  struct drm_dp_mst_branch *mstb)
f8df31d5 Lyude Paul           2018-09-18  3136  {
f8df31d5 Lyude Paul           2018-09-18  3137  	struct drm_dp_mst_port *port;
f8df31d5 Lyude Paul           2018-09-18  3138  	bool exists = false;
f8df31d5 Lyude Paul           2018-09-18  3139  
f8df31d5 Lyude Paul           2018-09-18  3140  	mstb = drm_dp_get_validated_mstb_ref(mgr, mstb);
f8df31d5 Lyude Paul           2018-09-18  3141  	if (!mstb)
f8df31d5 Lyude Paul           2018-09-18  3142  		return false;
f8df31d5 Lyude Paul           2018-09-18  3143  
f8df31d5 Lyude Paul           2018-09-18 @3144  	list_for_each_entry(port, &mstb->ports, next) {
                                                                            ^^^^
We need to use a different loop iterator, or possibly
list_for_each_entry_safe() because it looks like we're freeing
something.  Maybe it's cleanest to do both.

f8df31d5 Lyude Paul           2018-09-18  3145  		port = drm_dp_get_validated_port_ref(mgr, port);
f8df31d5 Lyude Paul           2018-09-18 @3146  		if (!port)
f8df31d5 Lyude Paul           2018-09-18  3147  			continue;
f8df31d5 Lyude Paul           2018-09-18  3148  
f8df31d5 Lyude Paul           2018-09-18  3149  		exists = (port->connector == connector ||
f8df31d5 Lyude Paul           2018-09-18  3150  			  (port->mstb &&
f8df31d5 Lyude Paul           2018-09-18  3151  			   drm_dp_mst_connector_still_exists(connector, mgr,
f8df31d5 Lyude Paul           2018-09-18  3152  							     port->mstb)));
f8df31d5 Lyude Paul           2018-09-18  3153  
f8df31d5 Lyude Paul           2018-09-18  3154  		drm_dp_put_port(port);
f8df31d5 Lyude Paul           2018-09-18  3155  		if (exists)
f8df31d5 Lyude Paul           2018-09-18  3156  			break;
f8df31d5 Lyude Paul           2018-09-18  3157  	}
f8df31d5 Lyude Paul           2018-09-18  3158  
f8df31d5 Lyude Paul           2018-09-18  3159  	drm_dp_put_mst_branch_device(mstb);
f8df31d5 Lyude Paul           2018-09-18  3160  	return exists;
f8df31d5 Lyude Paul           2018-09-18  3161  }
f8df31d5 Lyude Paul           2018-09-18  3162  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
