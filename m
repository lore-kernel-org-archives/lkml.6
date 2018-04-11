Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754047AbeDKRHg convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 13:07:36 -0400
Received: from g2t1383g.austin.hpe.com ([15.233.16.89]:55564 "EHLO
        g2t1383g.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752915AbeDKRHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 13:07:34 -0400
From: "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>
To: Jack Wang <jinpu.wang@profitbricks.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] block: ratelimite pr_err on IO path
Thread-Topic: [PATCH] block: ratelimite pr_err on IO path
Thread-Index: AQHT0ZgWDCIAk4gmlU2GM3e1ct2oqqP7yn+Q
Date: Wed, 11 Apr 2018 17:07:30 +0000
Message-ID: <AT5PR8401MB1169413938950BBB0D30A24CABBD0@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
References: <1523452889-16331-1-git-send-email-jinpu.wangl@profitbricks.com>
In-Reply-To: <1523452889-16331-1-git-send-email-jinpu.wangl@profitbricks.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=elliott@hpe.com;
x-originating-ip: [15.211.195.7]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB0578;7:Vv+3u/+Feo/t2inV5uezOw44obHUMPV1g/jpU5k89+eXi+MjgMDZB4bBAEh7n55bLCTRx+ZUZKe/+XV+6tMBPekEMk4Flip53IatY65tRVkFCbfK8392eOpdhMTeSAclJ6Bv7tRPghpBPrHrIMVOXlI8923RpMNhC+/a9XYucVt8Z+u38ZoQkDTMgOx/fkRvmUe0zYvtyMYbKk85Nq59Hdp7WfJx81c6ij8Z/KM22U0Oa2ImnCMS2N8GXpgtIOcm
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989080)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(48565401081)(5600026)(3008032)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB0578;
x-ms-traffictypediagnostic: AT5PR8401MB0578:
x-microsoft-antispam-prvs: <AT5PR8401MB05780972F6EBD7ADD083F094ABBD0@AT5PR8401MB0578.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:AT5PR8401MB0578;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB0578;
x-forefront-prvs: 0639027A9E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(376002)(346002)(396003)(39860400002)(13464003)(199004)(189003)(4326008)(14454004)(2906002)(5250100002)(486006)(106356001)(2501003)(229853002)(5660300001)(54906003)(97736004)(186003)(74316002)(99286004)(110136005)(25786009)(7736002)(305945005)(476003)(6436002)(316002)(6116002)(3846002)(2900100001)(26005)(446003)(8936002)(6246003)(105586002)(11346002)(8676002)(3280700002)(55016002)(478600001)(9686003)(76176011)(66066001)(68736007)(3660700001)(81156014)(53936002)(81166006)(33656002)(53546011)(6506007)(86362001)(7696005)(102836004);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB0578;H:AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 3H8+4Jiv+oH9kwOf9hzfE5lUNBapkPSJMuJ7gP0egsZzkv/idf6+hU7DpVMImh84d8EwnX1SLuox9yUbk8s6hmeQRgCnnAS7GPOOU0no2Jhl6P/Z6qGv3NfcAWdmBkI8IwrJFLgDcueMogUljJmUBVPNy9KKFLvRi1DaGHN8K+7elAnTFfd1lLtTgm4wrb/Gr25h+xghpiQzVVirYnreCZTNFm+BLVW2HuNASFKiym+yHgAQd/ZkjzXo96WyM6dGVvlFJiO6KsCQg1RXzr1khbY43xOfSFlzGFfCxTi+Pg40aVU/JCDVqkbr6tzwgd2fKFqYradcFFAP+6/BTBttl1jD8qfNsjJmLo9UDQiMvyTgHgzCKr/W8rLlJrD/4vy30Y4AQrztHMGDiSsoeIpRVXlkfB7sMvrGYELb8K6Qymc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 139a9d93-4eb1-4a24-0f27-08d59fceb5d9
X-MS-Exchange-CrossTenant-Network-Message-Id: 139a9d93-4eb1-4a24-0f27-08d59fceb5d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2018 17:07:30.4523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB0578
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> owner@vger.kernel.org] On Behalf Of Jack Wang
> Sent: Wednesday, April 11, 2018 8:21 AM
> Subject: [PATCH] block: ratelimite pr_err on IO path
> 
> From: Jack Wang <jinpu.wang@profitbricks.com>
...
> -				pr_err("%s: ref tag error at location %llu " \
> -				       "(rcvd %u)\n", iter->disk_name,
> -				       (unsigned long long)
> -				       iter->seed, be32_to_cpu(pi->ref_tag));
> +				pr_err_ratelimited("%s: ref tag error at "
> +						   "location %llu (rcvd %u)\n",

Per process/coding-style.rst, you should keep a string like that on
one line even if that exceeds 80 columns:

  Statements longer than 80 columns will be broken into sensible chunks, unless
  exceeding 80 columns significantly increases readability and does not hide
  information. ... However, never break user-visible strings such as
  printk messages, because that breaks the ability to grep for them.
