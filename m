Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B3FC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 15:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41E5821524
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 15:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="ExGdBmp+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41E5821524
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbeHJR5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 13:57:39 -0400
Received: from mail-eopbgr60044.outbound.protection.outlook.com ([40.107.6.44]:54192
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727404AbeHJR5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 13:57:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zne6b/CY0YED3YKGPgedg8HlcdAHCNxCb5JnrMxftG8=;
 b=ExGdBmp+1o+F84DQc45oK3P339PJccx413e5CwSsaogmYOOO9y1zogYwyxQVONLsrL/GOFAY06rs6skw50a5WjaE/Ih53Xp8Qx58WhREkNn0H4Q1sDCh6IBGp+DgbhdYEJVFr5fj4Oo3RDpYEAqOmsx/bF7cGN7FA6BSBBhIpQI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=idosch@mellanox.com; 
Received: from localhost (79.181.90.23) by
 DB7PR05MB4985.eurprd05.prod.outlook.com (2603:10a6:10:22::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Fri, 10 Aug 2018 15:26:36 +0000
Date:   Fri, 10 Aug 2018 18:26:31 +0300
From:   Ido Schimmel <idosch@mellanox.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     davem@davemloft.net, jiri@mellanox.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] mlxsw: core: remove unnecessary function
 mlxsw_core_driver_put
Message-ID: <20180810152631.GB11917@splinter.mtl.com>
References: <20180810023730.13140-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180810023730.13140-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [79.181.90.23]
X-ClientProxiedBy: DB6P193CA0009.EURP193.PROD.OUTLOOK.COM (2603:10a6:6:29::19)
 To DB7PR05MB4985.eurprd05.prod.outlook.com (2603:10a6:10:22::25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2aec8c1c-2788-4628-a104-08d5fed5a98a
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR05MB4985;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR05MB4985;3:y82+zbyFcsqTwU1j1PTxDYaDUeEgc2A5R4f0deb6Z+NwkNs5ae8pZ0QkOSJaCkbGuViqaHrxqBtGaDFL3lflwMdzXY0DDmiLMDC5rzJHFF9G3Iu16Rls5Ma3xxxnGS11hS25fGyBXwdQP68KG0oKTH3VzKMfxBBsjHJ6I3TMkFiFa+wJBtLO1v1yYZ5WW9lvkBtHnvxi+AYhQmJjJRBgSNqNrC4INR9YPvto1M+CvxC3eBeNhoryT7O3mPqvLSXX;25:Js5RBVQGaQjx1Z4c7smy1i5X8hkd/6HB6trfxVUcmtdma0fYSHEG6Jy7SxoGt5dr6eT/kBNPByN9vDiPQ/907DuUQRUoEDGlLqEe/YXUgW2VXoZVIJMqjA5APGcfKt2e9AOYR0sHJjHEGhizK7QSIbY/56xetjGcB5oOCuGaL4GIYcK5kBRpOc2dckSvl3VW2RLaw/2yzF5yK/t+6Xqub+Vv2DOQ4dU8IkRoQ2G7K+k/vroKljlKJlEVDKwl53P+GTw7t7vsjDMNT+muG4TzHL5ipLrkXgjW3xcG6PbPPYQx2579vN3KRUpekcVf5GOLibG9f9LcDrxHAiZa+iEHSQ==;31:T5rexkUPqqQgsfaAdXiE/ot2y5FgJTw3r9VfA/j6pcDqQi7sTzBdS/nZTIUyv5ewkH/WZoIHMjc8tpl+7KcuGw3pWwwrDBEfndnzUvPfxqUVY67SvR6FnfUtw4Rz/rIjB73bWveEIV8o3wm6abbcPYvZlJIGyBEO3fCFxbgYTZSLXrGPjv/796ROI3anZSdsbOZoAw+wV4iN1kElJEEfUW2cwdz1E/GxMcBOIe4ajt0=
X-MS-TrafficTypeDiagnostic: DB7PR05MB4985:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR05MB4985;20:t04PmjEZTchqRPh0COpoUtV/+AfWACTqrn2keK9mv3jKM8U/ew5kWeDskaLPoVpXcRfEj7naAOb5vVFyoWYfHbEEigHa+wYhGnzEXM9YS9P+MVCY7cWpDSK4gj5DbQrJEIjDax0AdCuZlbDyU/iYCBB9iSi4GeqF7CLEbOVGxOoaPFVSJEE6n5LN0D5R8ZB+bEcEt/7PmpGAGfYRinGHTegIZFwEEtwyW5GlicFoHApHExctiCHS8lvFRShz4HJjF7yTCtASQSPBmjpnZ8luxfM1wxUa2FILYW1NQEF8ndSgxn3CCHd0xlHrj46JiqGmbYN/rUcqTiouIV7JnK6VcjDGLbZUBa32kl7feAYu1ilR/gpsXkwUvAaoS3L0723cU05SU4oSLDkaTzwxLW3lYFvrWT+jRiBHiymDsrsUorNZ6NJuICrD+qj2Gb1jwSXQWPKDMHUFw8IkN5AY9XZ9IPLlRJ5xTdAJ0CqHsuGx4DwgC9jnLcgwF19Ezo04Wyy/;4:0jFwVEHmc0rcj3fGctHZ/VUH6npfhVWOQwGY0ISnmTF9/OytTicMaaJldMDTgNRMKDXlVafb4DPIJ4YV56X9m/8o95lh0yG+9Cr0sr57e5/NXCll1k+VflEijjUxcMVhNUVzpIRkQbhnngohOzC0M82ZRjsB+oBQZo/17ZUjgOmf1/L7N+c9z8oLvY1w85dPMafQy+mv291iTpUBEaVWdmV4EZODeLyp6eUpgFn/d1dqFXvUbI/fgXbPbGO0H7W1sk8P/vCToNxeYEZq9H8QHMACoTl2OeS+OknnZLfFwDDtLYdxtPcyKeWhZUYa0veK
X-Microsoft-Antispam-PRVS: <DB7PR05MB4985A8257D81A5B9532544BABF240@DB7PR05MB4985.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(50582790962513);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB7PR05MB4985;BCL:0;PCL:0;RULEID:;SRVR:DB7PR05MB4985;
X-Forefront-PRVS: 07607ED19A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(6069001)(366004)(396003)(376002)(346002)(136003)(39860400002)(199004)(189003)(81156014)(97736004)(81166006)(5660300001)(33656002)(76506005)(8676002)(2906002)(68736007)(4326008)(106356001)(105586002)(58126008)(6666003)(229853002)(316002)(9686003)(6916009)(16586007)(478600001)(6486002)(47776003)(66066001)(8936002)(7736002)(53936002)(446003)(6116002)(3846002)(1076002)(25786009)(33896004)(86362001)(23726003)(50466002)(26005)(16526019)(186003)(476003)(956004)(76176011)(305945005)(6496006)(386003)(52116002)(486006)(6246003)(11346002)(18370500001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR05MB4985;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR05MB4985;23:N+LRLBrt2y4YAnN7DpSWP+S+7o4GwbFtGv2bqGVr3?=
 =?us-ascii?Q?g1q+m5Xlh0GgykZf8lBUH4QUe+/MrYwbt4eSWq7WHcXT2EnWcay4IkiCnpI8?=
 =?us-ascii?Q?G+fbxGPHSkS86UzKWoTu3Gh0+krWXmpDov0RUmTbr5Sj+4Vu8omRbQ7IxCDq?=
 =?us-ascii?Q?RpXKf/SBrB+zWfgqgOBVxhvkMhcC1yJ34Q/foqnBXlQR1HMQ6iEYM3LxQjs5?=
 =?us-ascii?Q?ama0ktF7q25fA2l5e6xjenAZ9SV14+PKxbvI7T+7qbquiumsT9sDe2pwRQxN?=
 =?us-ascii?Q?uYHQ5l+Tdl56oo4e9qWfxLmkOkkU54bYXNoeIyLjUwjOvuBf9+zhthYr1DC5?=
 =?us-ascii?Q?3kzm9K+CeQAQyIb8/IeyUi1K4RfGrvWfdkvJMMfdxUBtXi5Dy8MZD/vQi1aY?=
 =?us-ascii?Q?aXGsTW581oPm7hPIO+VXSdWw7+Kz6bkkkQdybNYf9l5//vyTCgvV4AaiKGZ/?=
 =?us-ascii?Q?0BrJ1G0TnX5t6gunBtqSCbgK3EX4L9yTCXEi9Cus4/mcVeY+pX39zoXznmD2?=
 =?us-ascii?Q?QN0ygjCLIMaTehrb58g0Wgv5ajocHQTnnVSR2Qi8DiELE0uPvzB1AWP4+SJT?=
 =?us-ascii?Q?u0xetsJDgx09z2SgQxoseY3AwNBFTdudUbLTzixMdNffTBFBRnh7IAEdIzd4?=
 =?us-ascii?Q?nDZvcyKoQ4UswT9DCjoPeC5H/ZF9CU6YlbDkW3unI78mP7gecC0/peEZsNQo?=
 =?us-ascii?Q?rXbA1xmwopBIU07HjnxeOZanp6TQ/FK7H2B63DeVdbUn+hMpmzrJyYMsO/Oz?=
 =?us-ascii?Q?V2dH63EMXRqe+TtBGBKiqE8s2LaoQ1oGgrlALy+MkeH93sXMBAer8HH5cjKf?=
 =?us-ascii?Q?4YSm7lHgasC1MtqKprGZ2G6rYp2R8w6tflPJY/dV7ZSSFOjh1EKP5b7HaMIm?=
 =?us-ascii?Q?J5O8dfiek7GQW8Bm6SZOW0E7DezCWknfG/VwcrW4OFrv8r0O0D+VzVA8QBn0?=
 =?us-ascii?Q?eG3Ne4GaasP4YIUIedi01KdSIaue69vIH39LfvxMLUyrP9K59XKzNrQMfw4v?=
 =?us-ascii?Q?RfJBL/ol3MJVbgUnf1N1KiQ+vGICQP19LROm0OA4swIolrp7TjrO8jK7ZXb9?=
 =?us-ascii?Q?ki7zuvWLba8LWtsk0ZXGukyE4/GK/rtU6wvuNgKPdzvl9sjptPh724aBULRj?=
 =?us-ascii?Q?xpuWdlZbM7bKANvAyr083LQXNJrhxeLquX3fAyDlmamp4oKwXQyARQWgP0Dd?=
 =?us-ascii?Q?YFqNLUC5PyyEURK2gyS9nnsyL31N0uPBakC9vP+p6yBNjRWYSTFaj/eI/Ane?=
 =?us-ascii?Q?DGc2DsFjGgSnlXl9S5b4p+HkdCP518krQPQ0lYl6H+ad/faQA097V5FwkcYy?=
 =?us-ascii?Q?pyDuuVD+gZwSCXRdjKzDbKKhZvz2DgyQiHSmcn6O+nFccetjawtcG0dUSj/Y?=
 =?us-ascii?Q?Zqica8Vd+DMaDpqOttvC9vtOBc=3D?=
X-Microsoft-Antispam-Message-Info: n9L75/h0FCncI+VanDIgevzZ75tJ/EqcOORrc+SkVvUi07FlX4MQGMCUeT8iBpKcG7GwPTwsjbaXSRYw7ht6ek5zow9CcfUTBqwZSlD/eCRBDRU/YNHJK0PYD6JIGh3myvaBTCwyx55vGYarYrdJdmJ/Cp0xZy9zGcHVWnw1+xEM303oGlSShTLs8UMASS6aH17sHfNAu7QBj5NeT+KA9vKcieB5osCkgyAcMdKMa7pc/+WzjidkuMax5l/gO6OF1ZC/0TF+irC6pQyXfL401iCG/frrMlA6nSMn55RV9zn+81bufQZVdc6m9HXRsScsPet/6VpnwblGCFFsNkZRlDTaIkvsk9zz/HoFj4nr2xg=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR05MB4985;6:zg5mE5c+VzFlpL3MrbTh8ltUze43Vo6Pg/WhOa+zIXjItcix4YRjs9WmyM85lmsqJhhByh6AuZePlTlarFsJn9nTXb2l+Z8hrCeq+uPR0MvkI9bNqTfp2jaK6XAwET9CcH+k2FolRd+ESW59o121yfDhglQHQxGNT0ppWKPcX2FZFfoUf3iz20xLnoovhgWI0XtPTmRDANfwqMY5iegalL381F4DaytUQiOa/+lsT5/6cZIaIdtjOIZvW36KZXGPUPVSGl7cTOXMAAiYdgDDRBy4l9EyHpbJben4MFj0dImasL5ziL9GEK20yyvJ7UQEM4b9pfvoTKJ8u6baK37oSKfXvrVhGJPLVPCSO0cUzPbKQRjqhpMU7JZTKmCiNsy1FQQywU8LwBzW0lWempgdW+GkxOPio6YtGn2xsKOpHNEKThzUeTfRXxBAQx8nqzplfd7JzTbIeW1+7gqT3eid7A==;5:1D48ftSfgh4VsU53UbTcrM7XHdRVjAaJahPkf58+9FbP1W4e3S28mVlXrgeag3S5fYIbnBy/O7sYqAVv5F6+lDTRVVXkzXiFvE+pdq4jna5f+v/Yh1doXQClBF/ecbl//DylYlXdm1GFWCcgq4EO8+EkEd/Mia0UuqyyJzkVGm8=;7:Cs0N3pK0uJ3AuMinKEDCsZSlYYH8E5XY65DHtlQh7GPcBWmcqD4F7qAfS2NKuEwSL3E/bkqMZ8nMzGJziPVMH0krjlKltjZJkK/8YI0v0tEYILbf08xGEa0JIAObVGO/MSy6miFFk6CRcS3OyrNlgKwR8y/w49L6sxvx3YabbxYetw5JPpePa5RoA89yB4J5WSa/RnTCvuKvYIQHzw8GhTrXJlZQ7gFaWsyRtngJIKal8hMiG2XHU4icqJw62rbe
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2018 15:26:36.5214
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aec8c1c-2788-4628-a104-08d5fed5a98a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR05MB4985
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 10:37:30AM +0800, YueHaibing wrote:
> The function mlxsw_core_driver_put only traverse mlxsw_core_driver_list
> to find the matched mlxsw_driver,but never used it.
> So it can be removed safely.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Ido Schimmel <idosch@mellanox.com>

FWIW, this function used to call module_put(), but it was removed in
commit 1d20d23c59c9 ("mlxsw: Move PCI id table definitions into driver
modules").

Thanks!
