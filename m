Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FEEBECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA9D22152A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="f3FHLG9x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA9D22152A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388133AbeIUAEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 20:04:24 -0400
Received: from mail-eopbgr40058.outbound.protection.outlook.com ([40.107.4.58]:10416
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727171AbeIUAEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 20:04:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQYXk091Q0lyVSU1Km6t2EE8KWTpjm86NJPV/Nq08Yc=;
 b=f3FHLG9x9/kI2ECDcitgXOBglXAoN8aIhcD8FqZNvMtcn0omT5vhp4Nx2izCYfY6hh3xLezYf0kUkxns2tleKoxRlpTyRJmjkQzCo8J+Eoee99JdhWSwzb5nT8wkZCqtj6JXX9NnBUkVjD8/vxNr9Wtol7cGMTKFpGEoa1EN0UM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from mlx.ziepe.ca (174.3.196.123) by
 AM6PR05MB4455.eurprd05.prod.outlook.com (2603:10a6:209:43::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Thu, 20 Sep 2018 18:19:31 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@mellanox.com>)
        id 1g33Xv-00020O-4z; Thu, 20 Sep 2018 12:19:23 -0600
Date:   Thu, 20 Sep 2018 12:19:23 -0600
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Alex Rosenbaum <alexr@mellanox.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Christoph Hellwig <hch@lst.de>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Don Dutile <ddutile@redhat.com>,
        Doug Ledford <dledford@redhat.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@mellanox.com>,
        John Hubbard <jhubbard@nvidia.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Noa Osherovich <noaos@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: Linux RDMA mini-conf at Plumbers 2018
Message-ID: <20180920181923.GA6542@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [174.3.196.123]
X-ClientProxiedBy: YTOPR0101CA0062.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::39) To AM6PR05MB4455.eurprd05.prod.outlook.com
 (2603:10a6:209:43::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1fb7d7d-f04e-4b07-3c69-08d61f259bff
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR05MB4455;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR05MB4455;3:nu5uLOKEELGqpyH3chduiDUs6Ka5snn4fYNjy1sCoLB4ChOoMags6q41SzbS8jUFOvgdtTymqT+LNnziCpzj3Ktr/BXlT1UYRBjl0lCgcnd6jvOZa1a75Q8lMHZ8+DS7Kfpjx/o9NnMNVRw4PirknhWZGWA+akynoiufQAxlf5y7mnm+BMMN/pEPTsCQjnPLskBwCkoqzpLts73+O65cX0ANVvX/i08uGiSFkgIX7Hx4UtDQAl0xTJkuhuxuhN1f;25:VdKYnQDD1ELteCmZFIkbuDA2kpECxTuybEkq8Xxbx0FwGd01U6m0O9AHMh0RxaQ6sjJrwNZg7BSKs4tjvejZBUyP87uMsW2qxjXns/utdk0DkJrPYEjCkDJTI81AT/Syvr3iQCzTVSNV6TMWDo4na9VJhxK9lm+02/I0JiF1MDJx2nAqqvUW8QaMd5KEmjbnfZxKqQ5aCR/RRy2Vl5MHW/xgCQwpIzVXivas5POjo9wWGND7R9nciCTv4jqYcAqHRGdQWaVZ3VCkkzgMlixYX7EIKCqD8DXtSsXHDQbftgBlX9YMHAOb39fJshZvwzZR5x1g/Mq8LOPaj9dq6YJCMw==;31:ONHahVe7NPgI91/j4RGNmmiW8IGPAuESwIlp96YQmYDC08ErVx7a67sQqcw4GMdv5MyT8LcezPZGx6ViE4JQ9F5VHP5QlAqHfUoKhzpmvTptDynPXWGw7Y3QdKG7lZZkppXBNVCjkQXZZnWmX3ajdG95BJL6rfe8t1AiGMdoNl9+uYXPRFzf42MBnTFTEwUz2abUYbH+oOT5SMEyeHnX1xyMXzVPDnAc4MymvHzw72Y=
X-MS-TrafficTypeDiagnostic: AM6PR05MB4455:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR05MB4455;20:GzdU0amgxQ6xiqrUl6+GeqTCZ5pGAyqkOjgCOfXwcq+bJk1C7dKPzGgePLTFRpKNMy75T4PFDcg6vROAD+5kw/E/OogHv2Q8Xw8SO6lb+VoyfIx/Quj4MyhbDv50/U6v+uSN57g9+cs9XCSWIHmxYyW+mpac+LtE2YlnhkakugmM+XSmhDC786qPnBMz2mFw0FGtkce5JN2vkbGqAZBdugBoHOLLbpsh+92gHSyaMNQlTBVkmirgdr59ck8fb1phBOTjFnjbSkCTVWtXCyagTWTUhleFPObMoKChls8wrxWyIacXWWwd/WRw5vlSpyT0tfqCWVy4rmAGTKSLjSLMXQAV7gDWzZJnT7VbuWH4qH5yF7u4Arfde8j4Jpf4z6U5O9i1OX3n9GEbOSScJZcs3snYC1mXi/GVfZw1gGul8x0pC4rd8+ZUerq7QXibklHnBinXM0Xt/kNrLotNuIsXc1LpQnHAcFX1SPBgzLenvSadq0YFt7wBzg1rPWp4fGvn
X-Microsoft-Antispam-PRVS: <AM6PR05MB44551E23A3BDD8270803A29FCF130@AM6PR05MB4455.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(228905959029699)(18589796830644)(85827821059158)(767451399110)(211936372134217)(153496737603132)(192374486261705);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231355)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(201708071742011)(7699051);SRVR:AM6PR05MB4455;BCL:0;PCL:0;RULEID:;SRVR:AM6PR05MB4455;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR05MB4455;4:M4UfppGTgFZA6Pq2pf9lGorQJlqsmUvy+bXdrVbUJd15VzTw/qzyRl2a4RVBnCnA1eLjC1svUjfaiOB9l48gR/m9EvisWYMBch/Xpei7S93z0T27e2Wyf5yHS3madP7ytU5g0Xlhobwb0Fi+byuoFe005T/OFgmKVknsf4IN5kfO778Hpev9/6Cbx32IAs70jE7kiV0s0a8eiDQnsSgZp3H51ROEUw7IfOy67Guv6dSnj0eFRJYROJcOm7OVQk8oqjd4NbjQr9lEfhHHteLXndVQHrmPsjbW/kBq5OO0S1LjNPwSVTLK8qdo55o/0kEo4/V41PijdOESGCVObo2Lhzq1yS+OdooTzviiEROis/1IDaeARV194oedcEH9fSzsQudwj5jMeoRavj/YLjX07rr1R7rTakPB+Hmjxk0+wmABOEkj//zFIA6/uqheW4Gz8HxWkUcw+OoHftgans8+/QTtUHbpZ7B7+sU3nOpVzW1Q69whd7jx3XLFVO2m3pBz/H101Q2bt3Ir1Ei7jIhI7A==
X-Forefront-PRVS: 0801F2E62B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(366004)(346002)(376002)(396003)(39860400002)(199004)(189003)(8936002)(50466002)(2906002)(81166006)(81156014)(83796002)(105586002)(8676002)(57986006)(305945005)(106356001)(69596002)(7736002)(97736004)(7416002)(386003)(6306002)(53936002)(68736007)(2486003)(2870700001)(23676004)(52146003)(5660300001)(52116002)(1076002)(6116002)(122856001)(966005)(9746002)(478600001)(9786002)(3846002)(86362001)(26005)(316002)(14444005)(47776003)(33656002)(36756003)(186003)(46656002)(66066001)(58126008)(4326008)(2616005)(54906003)(39060400002)(486006)(476003)(18370500001)(24400500001)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB4455;H:mlx.ziepe.ca;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTZQUjA1TUI0NDU1OzIzOndYMVpVdlFLN2NrY3lkK2cvVVRjUEVJdlFo?=
 =?utf-8?B?dEx6UDd3TVRqMFIrdDZlUy9Yb09kWlFlUFZzUUFHOHV0RjV3L2l5Qmc5UUlT?=
 =?utf-8?B?TkdEOHQ3TzFtMHh4V0xpQXh1dFBuOFI1blVxcXRWdXhUb1pGTjgyOTVzL1Vo?=
 =?utf-8?B?YXB0N04zdkk1M3pBcERSQ3dMdkRYckJscElWUXpRd04rUHRzM3Z2NldEd3ZN?=
 =?utf-8?B?ZStLVGwzRnVvdER2SmdIaVlOanJqWjRGSkdlK1MzKy81eE53MzRLZE9mOCs3?=
 =?utf-8?B?bmpoa3BLYmUwOXhWUWFZdXgyMGRBRzliSkxvcUJ0eWg4c3NZdm0rWThkbzZ2?=
 =?utf-8?B?WDRTNDJ4RGloU0RvRVZhN1g0VlRGU2N5N2pXQmJxVFR1c0JlemNKVkt2SXAz?=
 =?utf-8?B?aDlWTzhYVHRpL3pxbFY4QUYyYWJZVEg3OXRMQU1nb1lPN1FHV1JUSWJBUis4?=
 =?utf-8?B?Y3Fha3o3REJ2Q2ZJUEFac2VpaVlDUGE1amM2VlV5SFN5WjZwblRrSkZlQ2gv?=
 =?utf-8?B?emIvMy85R09VenVUL2cxUU5NZHZYWnhGejN6MW11bGZYek11YzN4QzRyVC9W?=
 =?utf-8?B?dklsWXIybGlZQnl2a2xaY0ltZURvQXJiWC8weDUzQjdOWW5uc0NOa2hUZytW?=
 =?utf-8?B?d2tOY1g4RjJBdXloZWxjM1VXZTNDUUZiUEFmM2xDcDRCUHliUjA5SURDWmRX?=
 =?utf-8?B?c2U4b0hnSUhOaEZLY25ib0x0T3hkTlFOcll0K1lOZVFaTXI2SFVpWmM5Q0Jy?=
 =?utf-8?B?WUpqZExreVZSckxxdFo1aEV5WFhQK3lnNmxoQlloNlVZdEx4d2UzV2hYZjBa?=
 =?utf-8?B?NDlQUFdDZ0MxMzl4N1dqbnZRY2FzTmJNUEJhSVJJMTZLemticWhMb3VRRGhF?=
 =?utf-8?B?MW9CQ1dRYlZjd01vcGZwUWl6aWJrQWMxaDczeklsZW5zSTF4YjczdHNEV204?=
 =?utf-8?B?SlRtSndhRkFBSzk0N3FPVmFFZGFOMi9vMWxiSEtlSzlJY24wSmF5VnhhZ1Nm?=
 =?utf-8?B?RVAvaDc5eDVtTThKOFd0SmlpaEh1dUpNT2xIYXRWLzQyMFdTYUpVQXVFRUhK?=
 =?utf-8?B?ZDdwSmZkMWJwY3BWYzUxN0J6bFlLeS81cURkUndSSkJtOE9JdStjSmpyS2ZF?=
 =?utf-8?B?cVR2aHN6WHdEVmYxd0d6SHQ4bjJVZ0ZKUEdMU3Y1NE9GL2lzS2Roa1RWSXlM?=
 =?utf-8?B?OVkzM2hscmdKWmxKaVA1Rys1d0taLytjZmpwM1RyM3FKcXF5MFEwV0dCUmNo?=
 =?utf-8?B?VmdBWG5ZNUZGUmcwZ1BZWkVzczZIZ0RTbzRSVDU1YzA5OEZFSTk3ZnVHZkwy?=
 =?utf-8?B?TmV6QWVvZmhNV1VWTUZpOE95cmtGbGFZTVRJeVAwNCtpNmFOVytTL0phQjZs?=
 =?utf-8?B?YzUyR2J4dHNoZDQzb2IvMVBXeWxtNzNxU3pJL2xFWnRpVmJvZmxsRlhWMVdy?=
 =?utf-8?B?ZWF3MjdHUkE4TVVYWHVZNnozT2FsdUo2TUxFOGRnYmxvSmcwOGpYelF1RUpq?=
 =?utf-8?B?cnVyeGJ1dXlXREQzNjNHa3BpWHJmMnlIQ1UzVks1VWNoUytmaE5Ia0dTUEYv?=
 =?utf-8?B?bEFZQTRuNmFGWEJ1NUc1Si91Uld5elNoVmhONUliRE5ScFlpV29hLzBkTGsy?=
 =?utf-8?B?T1pFTzlwSTlNQ3pFQ2JvQmY1MUY3R2xnVERFTEJQZ2JtZDQ0VmJSWHlPbG4r?=
 =?utf-8?B?MnRvczd4WVBEU05JWjJkb3JQWGpwVHJNMmJmOGlGTStTRzhFRGhyRmFEZGVm?=
 =?utf-8?B?aEh6K1BSTHN4UXR1TWNxMVhGcTFSVkhVNm44MFBnZ3NPNWxvV1Q3TGdoZWRv?=
 =?utf-8?B?eEVmYnp5Z3FxMnlCWUcvajMxSGtFR1h1dWtKU2V2QnYvWHBxblFhVXZqWFU3?=
 =?utf-8?Q?ljf83DWkPOg=3D?=
X-Microsoft-Antispam-Message-Info: ZZlfGAW6c3dcxM7HoQz1eMTTwswnX7foobJsPJfo+7X/mHkFyiam5UpSZWnbnqi/eot9zfY5Wm10Ut6j0ZMa9Pp+Q8j2V30Wf5imH1ZBTtLFz/xN95ARgMuGZbJJ08rK8/2T3ekQdodmGm4un50g15sNH8iS+0diYJCSE4ALQ263yIpzU2VMICRGnVpDLamk9vT1QeqLGhM9lsFX5NXOfR49zvwyH6syCLq7zw9NhrNgOCq8jIXK6cNfeAibt7N9Z5aw7W/AE0mXySPjo+SxY8Di4nyaO0UL7qdN3iusZYnIL6EA3JXKBwyr5vWDAn+uL1KSgxJV0lB+f6c+NsRMydzQwui4iPuZkBQZWwcMZR0=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR05MB4455;6:kJHB06Qd7OWiBX79P3kxSM4NA5BqamQX5Scp49hziFdWMBJ7sZgz2/tYDqzJl1g/Yezy8FMPeDZwZo5NhUUBLZuctJnIXlrOvXY0rgIBreX78E9SD5QgH/9/ZYCxVQqx+fUwpDp7Vv7cMiGXbfTJtw5ki3AsMqQAgR2n0mPsAVGkaHM8t/cZcffd+qRoEvkpPl/erINyEU73RlFmoZ/vOVETUKptyNesMeqvNgBKZpoF0DJvQBeGdJGtWQHqHLGSQw2TDlEIDPGYdaRKld706p31+jV9elYpx5kPwYbyjvchwQdn1okDuNYau/VqNnJ9VFPL8em9rb74xiVPm1vZu2dJCQ97bYPD4hjZ5fIgS/DT7Jt6vpeVdiJ6mclKqRNCuvXJOsQ8/Wdgu50y1VEpy0aNN3e68SbIJot+n5w8W3q2fqYZ49HL2sggCC0FXt5ubZuTnqathhrcWmwaDrepnA==;5:ko5oNV+SXjwQ3C+fxDh6L9BsUgLSZr2h/L99uUoYsDLsPj2Wt6IKmaE127fBRsFS8WY2Uz/EKYYK74+dhcBmkFLUVK+G5MX20liWe4r3FiG7Uz6i3g9g5qG0GNEhKcSdw63j1zzmC00E8XMy2INm9V/7xkx3VttjusTeQKxxuGM=;7:8LkqkMdw5Tx9k/6GVQ4osSK3aupyUHEWUEFq9YJB46JBppYPV9cLeSYTp/T+mwy2W9sCvsiqBXvOyjX8HWcNuHn7ZJq2kzPYARc5xDKQIOUwLsTPmDbcD6qDmtL1HfllDssf4C9/2CIajjoW0NQQrbavfKa1e6PEebHbU6XyuzHLXNN2jMPNd+LZNyQtokeJSgVGOZmHOMki1kqhiKHAYKwjoz5lFybXFA30mxBso6i4ej6Tu4WpubHg/qv/jHXh
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2018 18:19:31.0950
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1fb7d7d-f04e-4b07-3c69-08d61f259bff
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4455
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is just a friendly reminder that registration deadlines are
approaching for this conference. Please see

https://www.linuxplumbersconf.org/event/2/page/7-attend

For details.

This year we expect to have close to a day set aside for RDMA related
topics. Including up to half a day for the thorny general kernel issues
related to get_user_pages(), particularly as exasperated by RDMA.

We have been working on the following concepts for sessions, I've
roughly marked names based on past participation in related email
threads. As we get closer to the conference date we will be organizing
leaders for each section based on these lists, please let us know of
any changes, or desire to be a leader!

RDMA and get_user_pages
=======================
  Dan Williams <dan.j.williams@intel.com>
  Matthew Wilcox <willy@infradead.org>
  John Hubbard <jhubbard@nvidia.com>
  Nicholas Piggin <npiggin@gmail.com>
  Jan Kara <jack@suse.cz>

 RDMA, DAX and persistant memory co-existence.

 Explore the limits of what is possible without using On
 Demand Paging Memory Registration. Discuss 'shootdown'
 of userspace MRs

 Dirtying pages obtained with get_user_pages() can oops ext4
 discuss open solutions.

RDMA and PCI peer to peer
=========================
  Don Dutile <ddutile@redhat.com>
  Alex Williamson <alex.williamson@redhat.com>
  Christoph Hellwig <hch@lst.de>
  Stephen Bates <sbates@raithlin.com>
  Logan Gunthorpe <logang@deltatee.com>
  Jérôme Glisse <jglisse@redhat.com>
  Christian König <christian.koenig@amd.com>
  Bjorn Helgaas <bhelgaas@google.com>

 RDMA and PCI peer to peer transactions. IOMMU issues. Integration
 with HMM. How to expose PCI BAR memory to userspace and other
 drivers as a DMA target.

Improving testing of RDMA with syzkaller, RXE and Python
========================================================
 Noa Osherovich <noaos@mellanox.com>
 Don Dutile <ddutile@redhat.com>
 Jason Gunthorpe <jgg@mellanox.com>

 Problem solve RDMA's distinct lack of public tests.
 Provide a better framework for all drivers to test with,
 and a framework for basic testing in userspace.

 Worst remaining unfixed syzkaller bugs and how to try to fix them

 How to hook syzkaller more deeply into RDMA.

IOCTL conversion and new kABI topics
====================================
 Jason Gunthorpe <jgg@mellanox.com>
 Alex Rosenbaum <alexr@mellanox.com>

 Attempt to close on the remaining tasks to complete the project

 Restore fork() support to userspace

Container and namespaces for RDMA topics
========================================
 Parav Pandit <parav@mellanox.com>
 Doug Ledford <dledford@redhat.com>

 Remaining sticky situations with containers

 namespaces in sysfs and legacy all-namespace operation

 Remaining CM issues

 Security isolation problems

Very large Contiguous regions in userspace
==========================================
 Christopher Lameter <cl@linux.com>
 Parav Pandit <parav@mellanox.com>

 Poor performance of get_user_pages on very large virtual ranges

 No standardized API to allocate regions to user space

 Carry over from last year

As we get closer to the conference date the exact schedule will be
published on the conference web site. I belive we have the Thursday
set aside right now.

If there are any last minute topics people would like to see please
let us know.

See you all in Vancouver!

Thanks,
Jason & Leon
